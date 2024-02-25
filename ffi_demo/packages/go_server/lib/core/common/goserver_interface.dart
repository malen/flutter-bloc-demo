import 'start_config.dart';

abstract class GoServerInterface {
  Future<int> start(StartConfig cfg);

  Future<void> stop();
}
