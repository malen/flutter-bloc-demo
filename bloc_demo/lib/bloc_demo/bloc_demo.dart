import 'package:bloc/bloc.dart';

// 封闭类只能在同一个库中被继承。它是隐式抽象的，不能直接实例化。
sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>(
      (event, emit) {
        emit(state + 1);
      },
      // TODO: transfromer 中的debounce貌似要依赖rxdata
      // transformer: (events, mapper) {
      //   return events.debounceTime(const Duration(milliseconds: 300)).asyncExpand(mapper);
      // },
    );
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print(transition);
  }

  // EventTransformer<T> debounce<T>(Duration duration) {
  //   return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  // }
}

void main(List<String> args) {
  CounterBloc()
    ..add(CounterIncrementPressed())
    ..close();
}
