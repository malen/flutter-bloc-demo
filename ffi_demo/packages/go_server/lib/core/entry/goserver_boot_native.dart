import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:go_server/core/common/goserver_ffi.dart';
import 'package:go_server/core/common/goserver_interface.dart';
import 'package:go_server/core/common/start_config.dart';
import 'package:go_server/core/ffi/goserver_bind.dart';
import 'package:go_server/core/goserver_boot.dart';

GoServerBoot create() => GoServerBootNative();

class GoServerBootNative implements GoServerBoot {
  late GoServerInterface _goserver;

  GoServerBootNative() {}

  @override
  Future<int> start(StartConfig cfg) async {
    var port = await _ffiStart(cfg);
    return port;
  }

  @override
  Future<void> stop() async {
    await _goserver.stop();
  }

  _ffiInit() {
    var libName = "go_server.";
    if (Platform.isWindows) {
      libName += "dll";
    }
    if (Platform.isMacOS) {
      libName += "dylib";
    }
    if (Platform.isLinux) {
      libName += "so";
    }
    _goserver = GoServerFFi(GoServerBind(DynamicLibrary.open(libName)));
  }

  // FFI run in isolate
  Future<int> _ffiStart(StartConfig cfg) async {
    return await Isolate.run(() async {
      _ffiInit();
      return await _goserver.start(cfg);
    });
  }
}
