import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/images_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/widget_keys_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/models/game_pick.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';
import 'package:mocktail/mocktail.dart';

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}

class MockScoreCubit extends MockCubit<int> implements ScoreCubit {}

void main() {
  const gamePickButtonPaper = WidgetKeysConstants.gamePickPaperButton;
  const gamePickButtonRock = WidgetKeysConstants.gamePickRockButton;
  const gamePickButtonScissor = WidgetKeysConstants.gamePickScissorButton;
  final paperPlayerPick = GamePick(
    name: PlayerGamePick.paper,
    iconPath: ImagesConstants.icons.paper,
    gradientBorderFirstColor: ColorsConstants.gradient.paper.color.shade300,
    gradientBorderSecondColor: ColorsConstants.gradient.paper.color.shade400,
  );
  final rockPlayerPick = GamePick(
    name: PlayerGamePick.rock,
    iconPath: ImagesConstants.icons.rock,
    gradientBorderFirstColor: ColorsConstants.gradient.rock.color.shade400,
    gradientBorderSecondColor: ColorsConstants.gradient.rock.color.shade500,
  );
  final scissorPlayerPick = GamePick(
    name: PlayerGamePick.scissor,
    iconPath: ImagesConstants.icons.scissor,
    gradientBorderFirstColor: ColorsConstants.gradient.scissors.color.shade400,
    gradientBorderSecondColor: ColorsConstants.gradient.scissors.color.shade500,
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

      expect(find.byKey(gamePickButtonPaper), findsOneWidget);
      expect(find.byKey(gamePickButtonRock), findsOneWidget);
      expect(find.byKey(gamePickButtonScissor), findsOneWidget);
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
        expect(find.byKey(gamePickButtonPaper), findsOneWidget);
        expect(find.byKey(gamePickButtonRock), findsOneWidget);
        expect(find.byKey(gamePickButtonScissor), findsOneWidget);
        expect(gameScore, findsOneWidget);
        expect(rulesButton, findsOneWidget);
      },
    );
  });
}
