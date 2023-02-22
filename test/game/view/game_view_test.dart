import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';
import 'package:mocktail/mocktail.dart';

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}

class MockScoreCubit extends MockCubit<int> implements ScoreCubit {}

void main() {
  const gamePickButtonPaperKey = WidgetKeysConstants.gamePickPaperButton;
  const gamePickButtonRockKey = WidgetKeysConstants.gamePickRockButton;
  const gamePickButtonScissorKey = WidgetKeysConstants.gamePickScissorButton;
  final mockPicks = GameRepositoryStatic().getAllPicks();
  final mockPickPaper = mockPicks[0];
  final mockPickScissor = mockPicks[1];
  final mockPickRock = mockPicks[2];
  late GameBloc gameBloc;
  late ScoreCubit scoreCubit;

  setUp(() {
    gameBloc = MockGameBloc();
    scoreCubit = MockScoreCubit();
  });

  Future<void> pumpGameView(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: gameBloc),
            BlocProvider.value(value: scoreCubit)
          ],
          child: const GameViewDesktop(),
        ),
      ),
    );
  }

  group('GamePage', () {
    testWidgets('renders GameView', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GamePage()));
      expect(find.byType(GameViewDesktop), findsOneWidget);
    });
  });

  group('GameView', () {
    testWidgets('renders initial Game view without picks', (tester) async {
      when(() => gameBloc.state).thenReturn(const GameState());
      when(() => scoreCubit.state).thenReturn(0);

      await pumpGameView(tester);

      expect(find.widgetWithText(RulesButton, 'RULES'), findsOneWidget);
      expect(find.widgetWithText(GameScore, '0'), findsOneWidget);
    });

    testWidgets('renders initial Game view with picks', (tester) async {
      when(() => gameBloc.state).thenReturn(GameState(gamePicks: mockPicks));
      when(() => scoreCubit.state).thenReturn(0);

      await pumpGameView(tester);

      expect(find.byKey(gamePickButtonPaperKey), findsOneWidget);
      expect(find.byKey(gamePickButtonRockKey), findsOneWidget);
      expect(find.byKey(gamePickButtonScissorKey), findsOneWidget);
      expect(find.widgetWithText(RulesButton, 'RULES'), findsOneWidget);
      expect(find.widgetWithText(GameScore, '0'), findsOneWidget);
    });

    group('Rules modal', () {
      testWidgets('should display when rules button is clicked',
          (tester) async {
        when(() => gameBloc.state).thenReturn(GameState(gamePicks: mockPicks));
        when(() => scoreCubit.state).thenReturn(0);

        await pumpGameView(tester);

        final rulesModal = find.byType(RulesModal);
        final rulesButton = find.descendant(
          of: find.byType(RulesButton),
          matching: find.text('RULES'),
        );

        expect(rulesModal, findsNothing);
        expect(rulesButton, findsOneWidget);

        await tester.tap(rulesButton);
        await tester.pumpAndSettle();

        expect(rulesModal, findsOneWidget);
        expect(
          find.descendant(of: rulesModal, matching: find.text('RULES')),
          findsOneWidget,
        );
        expect(
          find.byKey(WidgetKeysConstants.closeRulesModal),
          findsOneWidget,
        );
      });

      testWidgets('should be dismissed when close button is clicked',
          (tester) async {
        when(() => gameBloc.state).thenReturn(GameState(gamePicks: mockPicks));
        when(() => scoreCubit.state).thenReturn(0);

        await pumpGameView(tester);

        final rulesModal = find.byType(RulesModal);
        final rulesButton = find.descendant(
          of: find.byType(RulesButton),
          matching: find.text('RULES'),
        );
        final closeModalButton =
            find.byKey(WidgetKeysConstants.closeRulesModal);

        expect(rulesModal, findsNothing);
        expect(rulesButton, findsOneWidget);

        await tester.tap(rulesButton);
        await tester.pumpAndSettle();

        expect(rulesModal, findsOneWidget);
        expect(
          find.descendant(of: rulesModal, matching: find.text('RULES')),
          findsOneWidget,
        );
        expect(closeModalButton, findsOneWidget);

        await tester.tap(closeModalButton);
        await tester.pumpAndSettle();

        expect(rulesModal, findsNothing);
        expect(rulesButton, findsOneWidget);
      });
    });

    group('Players picks board', () {
      testWidgets(
        "should be displayed user's pick after user chooses a pick",
        (tester) async {
          // when(() => gameBloc.state).thenReturn(
          //   GameState(
          //     gamePicks: mockPicks,
          //     userPick: mockPickRock,
          //     status: GameStatus.progress,
          //   ),
          // );
          whenListen(
            gameBloc,
            Stream.fromIterable(<GameState>[
              GameState(gamePicks: mockPicks),
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickRock,
                status: GameStatus.progress,
              ),
            ]),
            initialState: GameState(gamePicks: mockPicks),
          );
          when(() => scoreCubit.state).thenReturn(0);

          await pumpGameView(tester);

          final rockPickButton = find.byKey(gamePickButtonRockKey);
          final paperPickButton = find.byKey(gamePickButtonPaperKey);
          final scissorPickButton = find.byKey(gamePickButtonScissorKey);
          final rulesButton = find.widgetWithText(RulesButton, 'RULES');
          final score = find.widgetWithText(GameScore, '0');

          expect(rockPickButton, findsOneWidget);
          expect(paperPickButton, findsOneWidget);
          expect(scissorPickButton, findsOneWidget);
          expect(rulesButton, findsOneWidget);
          expect(score, findsOneWidget);

          await tester.tap(rockPickButton);
          await tester.pumpAndSettle(const Duration(seconds: 2));

          expect(rockPickButton, findsOneWidget);
          expect(paperPickButton, findsNothing);
          expect(scissorPickButton, findsNothing);
          expect(find.byKey(WidgetKeysConstants.emptyPick), findsOneWidget);
          expect(rulesButton, findsOneWidget);
          expect(score, findsOneWidget);
          // verify(() => gameBloc.add(GameUserPickedEvent(mockPickRock)))
          //     .called(1);
        },
      );

      testWidgets(
        "should be displayed home's pick after user chooses a pick",
        (tester) async {
          whenListen(
            gameBloc,
            Stream.fromIterable([
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickRock,
                status: GameStatus.progress,
              ),
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickRock,
                homePick: mockPickScissor,
                status: GameStatus.progress,
              ),
            ]),
            initialState: GameState(
              gamePicks: mockPicks,
              userPick: mockPickRock,
              status: GameStatus.progress,
            ),
          );
          when(() => scoreCubit.state).thenReturn(0);

          await pumpGameView(tester);

          final rockPickButton = find.byKey(gamePickButtonRockKey);
          final paperPickButton = find.byKey(gamePickButtonPaperKey);
          final scissorPickButton = find.byKey(gamePickButtonScissorKey);
          final rulesButton = find.widgetWithText(RulesButton, 'RULES');
          final score = find.widgetWithText(GameScore, '0');

          expect(rockPickButton, findsOneWidget);
          expect(paperPickButton, findsNothing);
          expect(scissorPickButton, findsNothing);
          expect(rulesButton, findsOneWidget);
          expect(score, findsOneWidget);

          await tester.pumpAndSettle(const Duration(seconds: 2));

          expect(rockPickButton, findsOneWidget);
          expect(scissorPickButton, findsOneWidget);
          expect(paperPickButton, findsNothing);
          expect(find.byKey(WidgetKeysConstants.emptyPick), findsNothing);
          expect(rulesButton, findsOneWidget);
          expect(score, findsOneWidget);
          // verify(() => gameBloc.add(GameHomePickedEvent())).called(1);
        },
      );
    });

    group('Game Finished', () {
      testWidgets(
        'should display YOU WIN, button PLAY AGAIN and increase score',
        (tester) async {
          whenListen(
            gameBloc,
            Stream.fromIterable([
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickRock,
                homePick: mockPickScissor,
                status: GameStatus.progress,
              ),
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickRock,
                homePick: mockPickScissor,
                status: GameStatus.finish,
                isUserWin: true,
              ),
            ]),
            initialState: GameState(
              gamePicks: mockPicks,
              userPick: mockPickRock,
              homePick: mockPickScissor,
              status: GameStatus.progress,
            ),
          );
          when(() => scoreCubit.stream)
              .thenAnswer((_) => Stream.fromIterable([1, 2]));
          when(() => scoreCubit.state).thenReturn(1);
          when(() => scoreCubit.increment()).thenReturn(null);

          await pumpGameView(tester);

          expect(find.byKey(gamePickButtonRockKey), findsOneWidget);
          expect(find.byKey(gamePickButtonScissorKey), findsOneWidget);
          expect(find.byKey(gamePickButtonPaperKey), findsNothing);
          expect(find.widgetWithText(RulesButton, 'RULES'), findsOneWidget);
          expect(find.widgetWithText(GameScore, '1'), findsOneWidget);

          await tester.pumpAndSettle();

          expect(find.text('YOU WIN'), findsOneWidget);
          expect(
            find.widgetWithText(ElevatedButton, 'PLAY AGAIN'),
            findsOneWidget,
          );
          expect(find.widgetWithText(GameScore, '2'), findsOneWidget);
          expect(find.widgetWithText(GameScore, '1'), findsNothing);
          verify(() => scoreCubit.increment()).called(1);
        },
      );

      testWidgets(
        'should display YOU LOSE, button PLAY AGAIN and decrease score',
        (tester) async {
          whenListen(
            gameBloc,
            Stream.fromIterable([
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickPaper,
                homePick: mockPickScissor,
                status: GameStatus.progress,
              ),
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickPaper,
                homePick: mockPickScissor,
                status: GameStatus.finish,
                isUserWin: false,
              ),
            ]),
            initialState: GameState(
              gamePicks: mockPicks,
              userPick: mockPickPaper,
              homePick: mockPickScissor,
              status: GameStatus.progress,
            ),
          );
          when(() => scoreCubit.stream)
              .thenAnswer((_) => Stream.fromIterable([1, 0]));
          when(() => scoreCubit.state).thenReturn(1);
          when(() => scoreCubit.decrement()).thenReturn(null);

          await pumpGameView(tester);

          expect(find.byKey(gamePickButtonPaperKey), findsOneWidget);
          expect(find.byKey(gamePickButtonScissorKey), findsOneWidget);
          expect(find.byKey(gamePickButtonRockKey), findsNothing);
          expect(find.widgetWithText(RulesButton, 'RULES'), findsOneWidget);
          expect(find.widgetWithText(GameScore, '1'), findsOneWidget);

          await tester.pumpAndSettle();

          expect(find.text('YOU LOSE'), findsOneWidget);
          expect(
            find.widgetWithText(ElevatedButton, 'PLAY AGAIN'),
            findsOneWidget,
          );
          expect(find.widgetWithText(GameScore, '0'), findsOneWidget);
          expect(find.widgetWithText(GameScore, '1'), findsNothing);
          verify(() => scoreCubit.decrement()).called(1);
        },
      );

      testWidgets(
        'should restart game when click in PLAY AGAIN',
        (tester) async {
          whenListen(
            gameBloc,
            Stream.fromIterable([
              GameState(
                gamePicks: mockPicks,
                userPick: mockPickRock,
                homePick: mockPickScissor,
                status: GameStatus.finish,
                isUserWin: true,
              ),
              GameState(gamePicks: mockPicks),
            ]),
            initialState: GameState(
              gamePicks: mockPicks,
              userPick: mockPickRock,
              homePick: mockPickScissor,
              status: GameStatus.finish,
              isUserWin: true,
            ),
          );
          when(() => scoreCubit.state).thenReturn(1);

          await pumpGameView(tester);

          final rockPickButton = find.byKey(gamePickButtonRockKey);
          final paperPickButton = find.byKey(gamePickButtonPaperKey);
          final scissorPickButton = find.byKey(gamePickButtonScissorKey);
          final rulesButton = find.widgetWithText(RulesButton, 'RULES');
          final score = find.widgetWithText(GameScore, '1');
          final playAgainButton = find.widgetWithText(
            ElevatedButton,
            'PLAY AGAIN',
          );

          expect(rockPickButton, findsOneWidget);
          expect(scissorPickButton, findsOneWidget);
          expect(paperPickButton, findsNothing);
          expect(rulesButton, findsOneWidget);
          expect(score, findsOneWidget);
          expect(playAgainButton, findsOneWidget);

          await tester.tap(playAgainButton);
          await tester.pump();

          expect(rockPickButton, findsOneWidget);
          expect(scissorPickButton, findsOneWidget);
          expect(paperPickButton, findsOneWidget);
          expect(rulesButton, findsOneWidget);
          expect(score, findsOneWidget);
          expect(playAgainButton, findsNothing);
        },
      );
    });
  });
}
