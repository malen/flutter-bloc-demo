import 'package:bloc/bloc.dart';

import 'cubit_demo.dart';

// 全局状态变化观察者
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('global change:${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('global error:${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main(List<String> args) {
  Bloc.observer = SimpleBlocObserver();
  CounterCubit(0)
    ..increment()
    ..close();
}
