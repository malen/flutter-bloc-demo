import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:go_server/api/model/create_task.dart';
import 'package:go_server/api/model/resolve_result.dart';
import 'package:go_server/api/model/result.dart';
import 'package:go_server/util/util.dart';

class _Client {
  static _Client? _instance;

  late Dio dio;

  _Client._internal();

  factory _Client(String network, String address, String apiToken) {
    if (_instance == null) {
      _instance = _Client._internal();
      var dio = Dio();
      final isUnixSocket = network == 'unix';
      var baseUrl = 'http://127.0.0.1';
      if (!isUnixSocket) {
        if (Util.isWeb()) {
          baseUrl = kDebugMode ? 'http://127.0.0.1:9999' : '';
        } else {
          baseUrl = 'http://$address';
        }
      }
      dio.options.baseUrl = baseUrl;
      dio.options.contentType = Headers.jsonContentType;
      dio.options.sendTimeout = const Duration(seconds: 5);
      dio.options.connectTimeout = const Duration(seconds: 5);
      dio.options.receiveTimeout = const Duration(seconds: 60);
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (apiToken.isNotEmpty) {
          options.headers['X-Api-Token'] = apiToken;
        }
        handler.next(options);
      }));

      _instance!.dio = dio;
      if (isUnixSocket) {
        (_instance!.dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
          final client = HttpClient();
          client.connectionFactory = (Uri uri, String? proxyHost, int? proxyPort) async {
            final socket = Socket.startConnect(InternetAddress(address, type: InternetAddressType.unix), 0);
            return socket;
          };
          // debugPrint("client xx");
          return client;
        };
      }
    }
    return _instance!;
  }
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}

late _Client _client;

void init(String network, String address, String apiToken) {
  _client = _Client(network, address, apiToken);
}

Future<T> _parse<T>(
  Future<Response> Function() fetch,
  T Function(dynamic json)? fromJsonT,
) async {
  try {
    var resp = await fetch();
    fromJsonT ??= (json) => null as T;
    final result = Result<T>.fromJson(resp.data, fromJsonT);
    if (result.code == 0) {
      return result.data as T;
    } else {
      throw Exception(result);
    }
  } on DioException catch (e) {
    if (e.type == DioExceptionType.sendTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout) {
      throw TimeoutException("rquest timeout");
    }
    throw Exception(Result(code: 1000, msg: e.message));
  }
}

Future<String> createTask(CreateTask createTask) async {
  return _parse<String>(() => _client.dio.get("/api/vi/tasks", data: CreateTask), (data) => data as String);
}

Future<void> pauseTask(String id) async {
  return _parse(() => _client.dio.put("/api/v1/tasks/$id/pause"), null);
}
