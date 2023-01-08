import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

void main() {
  group('ScoreCubit', () {
    test('initial state is 0', () {
      expect(ScoreCubit().state, 0);
    });

    group('increment', () {
      blocTest<ScoreCubit, int>(
        'emits [1] when state is 0',
        build: ScoreCubit.new,
        act: (cubit) => cubit.increment(),
        expect: () => [1],
      );

      blocTest<ScoreCubit, int>(
        'emits [1, 2] when state is 0 and invoked twice',
        build: ScoreCubit.new,
        act: (cubit) => cubit
          ..increment()
          ..increment(),
        expect: () => const <int>[1, 2],
      );

      blocTest<ScoreCubit, int>(
        'emits [11] when state is 10',
        build: ScoreCubit.new,
        seed: () => 10,
        act: (cubit) => cubit.increment(),
        expect: () => const <int>[11],
      );
    });

    group('decrement', () {
      blocTest<ScoreCubit, int>(
        'emits [0] when state is 1',
        build: ScoreCubit.new,
        seed: () => 1,
        act: (cubit) => cubit.decrement(),
        expect: () => [0],
      );

      blocTest<ScoreCubit, int>(
        'emits [2, 1] when state is 3 and invoked twice',
        build: ScoreCubit.new,
        seed: () => 3,
        act: (cubit) => cubit
          ..decrement()
          ..decrement(),
        expect: () => [2, 1],
      );

      blocTest<ScoreCubit, int>(
        'not emits when state is 0',
        build: ScoreCubit.new,
        act: (cubit) => cubit.decrement(),
        expect: () => <int>[],
      );
    });
  });
}
