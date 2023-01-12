import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/images_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/widget_keys_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/models/models.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';
import 'package:mocktail/mocktail.dart';

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}

class MockScoreCubit extends MockCubit<int> implements ScoreCubit {}

void main() {
  const gamePickButtonPaperKey = WidgetKeysConstants.gamePickPaperButton;
  const gamePickButtonRockKey = WidgetKeysConstants.gamePickRockButton;
  const gamePickButtonScissorKey = WidgetKeysConstants.gamePickScissorButton;
  final paperPlayerPick = GamePick(
    name: PlayerGamePick.paper,
    iconPath: ImagesConstants.icons.paper,
    gradientBorderFirstColor: ColorsConstants.gradient.paper.color.shade300,
    gradientBorderSecondColor: ColorsConstants.gradient.paper.color.shade400,
    buttonKey: gamePickButtonPaperKey,
  );
  final rockPlayerPick = GamePick(
    name: PlayerGamePick.rock,
    iconPath: ImagesConstants.icons.rock,
    gradientBorderFirstColor: ColorsConstants.gradient.rock.color.shade400,
    gradientBorderSecondColor: ColorsConstants.gradient.rock.color.shade500,
    buttonKey: gamePickButtonRockKey,
  );
  final scissorPlayerPick = GamePick(
    name: PlayerGamePick.scissor,
    iconPath: ImagesConstants.icons.scissor,
    gradientBorderFirstColor: ColorsConstants.gradient.scissors.color.shade400,
    gradientBorderSecondColor: ColorsConstants.gradient.scissors.color.shade500,
    buttonKey: gamePickButtonScissorKey,
  );
  final mockPicks = [paperPlayerPick, rockPlayerPick, scissorPlayerPick];
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
          child: const GameView(),
        ),
      ),
    );
  }

  group('GamePage', () {
    testWidgets('renders GameView', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: GamePage()));
      expect(find.byType(GameView), findsOneWidget);
    });
  });

  group('GameView', () {
    testWidgets('renders initial Game view', (tester) async {
      when(() => gameBloc.state).thenReturn(GameInitialState(mockPicks));
      when(() => scoreCubit.state).thenReturn(0);
      await pumpGameView(tester);
      final rulesButton = find.widgetWithText(OutlinedButton, 'RULES');
      final gameScore = find.widgetWithText(GameScore, '0');

      expect(find.byKey(gamePickButtonPaperKey), findsOneWidget);
      expect(find.byKey(gamePickButtonRockKey), findsOneWidget);
      expect(find.byKey(gamePickButtonScissorKey), findsOneWidget);
      expect(rulesButton, findsOneWidget);
      expect(gameScore, findsOneWidget);
    });

    testWidgets(
      'show game rules in modal when click in button RULES',
      (tester) async {
        when(() => gameBloc.state).thenReturn(GameInitialState(mockPicks));
        when(() => scoreCubit.state).thenReturn(0);
        await pumpGameView(tester);
        final rulesButton = find.widgetWithText(OutlinedButton, 'RULES');
        await tester.tap(rulesButton);
        await tester.pump();
        final rulesModal = find.byKey(WidgetKeysConstants.rulesModal);

        expect(rulesModal, findsOneWidget);
        expect(find.text('RULES'), findsWidgets);
        expect(
          find.byKey(WidgetKeysConstants.closeRulesModal),
          findsOneWidget,
        );
        expect(
          find.image(FileImage(File(ImagesConstants.rules))),
          findsOneWidget,
          skip: true,
          reason: 'Find other svg dependency and discover how to test',
        );
      },
    );

    testWidgets(
      'close rules modal when tap in close button and render initial Game view',
      (tester) async {
        when(() => gameBloc.state).thenReturn(GameInitialState(mockPicks));
        when(() => scoreCubit.state).thenReturn(0);

        final rulesButton = find.widgetWithText(OutlinedButton, 'RULES');
        final gameScore = find.widgetWithText(GameScore, '0');
        final rulesModal = find.byKey(WidgetKeysConstants.rulesModal);
        final closeRulesModalButton = find.byKey(
          WidgetKeysConstants.closeRulesModal,
        );

        await pumpGameView(tester);
        await tester.tap(rulesButton);
        await tester.pumpAndSettle();
        await tester.tap(closeRulesModalButton);
        await tester.pumpAndSettle();
        expect(rulesModal, findsNothing);
        expect(find.byKey(gamePickButtonPaperKey), findsOneWidget);
        expect(find.byKey(gamePickButtonRockKey), findsOneWidget);
        expect(find.byKey(gamePickButtonScissorKey), findsOneWidget);
        expect(gameScore, findsOneWidget);
        expect(rulesButton, findsOneWidget);
      },
    );

    testWidgets(
      'render user pick and house empty pick after user pick rock ',
      (tester) async {
        final rockPickButton = find.byKey(gamePickButtonRockKey);
        final paperPickButton = find.byKey(gamePickButtonPaperKey);
        final scissorPickButton = find.byKey(gamePickButtonScissorKey);

        whenListen(
          gameBloc,
          Stream.fromIterable(<GameState>[
            GameInitialState(mockPicks),
            UserPickState(rockPlayerPick),
          ]),
          initialState: GameInitialState(mockPicks),
        );
        when(() => scoreCubit.state).thenReturn(0);

        await pumpGameView(tester);

        expect(rockPickButton, findsOneWidget);
        expect(paperPickButton, findsOneWidget);
        expect(scissorPickButton, findsOneWidget);
        expect(find.widgetWithText(OutlinedButton, 'RULES'), findsOneWidget);
        expect(find.widgetWithText(GameScore, '0'), findsOneWidget);

        await tester.tap(rockPickButton);
        await tester.pumpAndSettle();

        expect(scissorPickButton, findsNothing);
        expect(paperPickButton, findsNothing);
        expect(rockPickButton, findsOneWidget);
        expect(find.text('YOU PICKED'), findsOneWidget);
        expect(find.byKey(WidgetKeysConstants.emptyPick), findsOneWidget);
        expect(find.text('THE HOUSE PICKED'), findsOneWidget);

        // await expectLater(
        //   gameBloc.stream,
        //   emitsInOrder([
        //     GameInitialState(mockPicks),
        //     UserPickState(rockPlayerPick),
        //   ]),
        // );
      },
    );

    testWidgets(
      'render user pick and house empty pick after user pick paper ',
      (tester) async {
        final rockPickButton = find.byKey(gamePickButtonRockKey);
        final paperPickButton = find.byKey(gamePickButtonPaperKey);
        final scissorPickButton = find.byKey(gamePickButtonScissorKey);

        whenListen(
          gameBloc,
          Stream.fromIterable(<GameState>[
            GameInitialState(mockPicks),
            UserPickState(paperPlayerPick),
          ]),
          initialState: GameInitialState(mockPicks),
        );
        when(() => scoreCubit.state).thenReturn(0);

        await pumpGameView(tester);

        expect(rockPickButton, findsOneWidget);
        expect(paperPickButton, findsOneWidget);
        expect(scissorPickButton, findsOneWidget);
        expect(find.widgetWithText(OutlinedButton, 'RULES'), findsOneWidget);
        expect(find.widgetWithText(GameScore, '0'), findsOneWidget);

        await tester.tap(paperPickButton);
        await tester.pumpAndSettle();

        expect(rockPickButton, findsNothing);
        expect(scissorPickButton, findsNothing);
        expect(paperPickButton, findsOneWidget);
        expect(find.text('YOU PICKED'), findsOneWidget);
        expect(find.byKey(WidgetKeysConstants.emptyPick), findsOneWidget);
        expect(find.text('THE HOUSE PICKED'), findsOneWidget);
      },
    );

    testWidgets(
      'render user pick and house empty pick after user pick scissor ',
      (tester) async {
        final rockPickButton = find.byKey(gamePickButtonRockKey);
        final paperPickButton = find.byKey(gamePickButtonPaperKey);
        final scissorPickButton = find.byKey(gamePickButtonScissorKey);

        whenListen(
          gameBloc,
          Stream.fromIterable(<GameState>[
            GameInitialState(mockPicks),
            UserPickState(scissorPlayerPick),
          ]),
          initialState: GameInitialState(mockPicks),
        );
        when(() => scoreCubit.state).thenReturn(0);

        await pumpGameView(tester);

        expect(rockPickButton, findsOneWidget);
        expect(paperPickButton, findsOneWidget);
        expect(scissorPickButton, findsOneWidget);
        expect(find.widgetWithText(OutlinedButton, 'RULES'), findsOneWidget);
        expect(find.widgetWithText(GameScore, '0'), findsOneWidget);

        await tester.tap(scissorPickButton);
        await tester.pumpAndSettle();

        expect(rockPickButton, findsNothing);
        expect(paperPickButton, findsNothing);
        expect(scissorPickButton, findsOneWidget);
        expect(find.text('YOU PICKED'), findsOneWidget);
        expect(find.byKey(WidgetKeysConstants.emptyPick), findsOneWidget);
        expect(find.text('THE HOUSE PICKED'), findsOneWidget);
      },
    );
  });
}
