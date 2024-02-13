import 'package:bloc_demo/cubit_demo/cubit_demo.dart';

Future<void> main(List<String> args) async {
  final cubit = CounterCubit(10);
  final subscription = cubit.stream.listen(print);
  cubit.increment();
  // 避免订阅被立即取消
  await Future.delayed(Duration.zero);
  await subscription.cancel();
  await cubit.close();
}
