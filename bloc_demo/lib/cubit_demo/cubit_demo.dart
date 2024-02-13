import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit(super.initialState);

  void increment() {
    // 每个Cubit都有一个addError方法，该方法用于指示发生了错误。
    addError(Exception('increment error!'), StackTrace.current);
    emit(state + 1);
  }

  @override
  // onChange 在state变化之前发生。
  void onChange(Change<int> change) {
    super.onChange(change);
    print('state is changed: $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}

void main(List<String> args) {
  final cubit = CounterCubit(10);
  print(cubit.state);
  cubit.increment();
  print(cubit.state);
  cubit.close();
}
