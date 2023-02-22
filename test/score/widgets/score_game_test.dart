import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';
import 'package:mocktail/mocktail.dart';

class MockScoreCubit extends MockCubit<int> implements ScoreCubit {}

void main() {
  late ScoreCubit scoreCubit;

  setUp(() {
    scoreCubit = MockScoreCubit();
  });

  Future<void> pumpGameScore(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: scoreCubit,
          child: const GameScore(),
        ),
      ),
    );
  }

  group('ScoreGameWidget', () {
    testWidgets('renders current ScoreCubit state', (tester) async {
      when(() => scoreCubit.state).thenReturn(5);
      await pumpGameScore(tester);

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets(
      'test increment',
      (tester) async {
        when(() => scoreCubit.state).thenReturn(5);
        // await tester.runAsync(() => scoreCubit.stream.first);
        // when(() => scoreCubit.state).thenReturn(6);

        await pumpGameScore(tester);
        scoreCubit.increment();
        await tester.pumpAndSettle();

        expect(find.text('6'), findsOneWidget);
        verify(() => scoreCubit.increment()).called(1);
      },
      skip: true,
    );
  });
}
