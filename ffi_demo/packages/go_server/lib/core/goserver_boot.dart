import 'package:go_server/core/common/start_config.dart';
import 'package:go_server/core/goserver_boot_stub.dart' if (dart.library.io) 'entry/goserver_boot_native.dart';

abstract class GoServerBoot {
  static GoServerBoot? _instance;

  static GoServerBoot get instance {
    _instance ??= GoServerBoot();
    return _instance!;
  }

  factory GoServerBoot() => create();

  Future<int> start(StartConfig cfg);

  Future<void> stop();
}
