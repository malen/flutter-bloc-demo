import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import 'package:go_server/core/common/goserver_interface.dart';
import 'package:go_server/core/common/start_config.dart';
import 'package:go_server/core/ffi/goserver_bind.dart';

class GoServerFFi implements GoServerInterface {
  late GoServerBind _goserver;

  GoServerFFi(GoServerBind goserver) {
    _goserver = goserver;
  }

  @override
  Future<int> start(StartConfig cfg) {
    var completer = Completer<int>();
    var result = _goserver.Start(jsonEncode(cfg).toNativeUtf8().cast());
    if (result.r1 != nullptr) {
      completer.completeError(Exception(result.r1.cast<Utf8>().toDartString()));
    } else {
      completer.complete(result.r0);
    }
    return completer.future;
  }

  @override
  Future<void> stop() {
    var completer = Completer<void>();
    _goserver.Stop();
    completer.complete();
    return completer.future;
  }
}
