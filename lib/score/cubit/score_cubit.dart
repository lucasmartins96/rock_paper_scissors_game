import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCubit extends Cubit<int> {
  ScoreCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() {
    if (state >= 1) {
      emit(state - 1);
    }
  }
}
