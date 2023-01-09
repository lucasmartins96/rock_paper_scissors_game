import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:mocktail/mocktail.dart';

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}

void main() {
  const gamePickButtonPaper = Key('player_game_pick_paper');
  const gamePickButtonRock = Key('player_game_pick_rock');
  const gamePickButtonScissor = Key('player_game_pick_scissor');
  late GameBloc gameBloc;

  setUp(() {
    gameBloc = MockGameBloc();
  });

  Future<void> pumpGameView(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: gameBloc, child: const GameView()),
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
      when(() => gameBloc.state).thenReturn(const GameInitialState());
      await pumpGameView(tester);
      final rulesButton = find.widgetWithText(OutlinedButton, 'RULES');

      expect(find.byKey(gamePickButtonPaper), findsOneWidget);
      expect(find.byKey(gamePickButtonRock), findsOneWidget);
      expect(find.byKey(gamePickButtonScissor), findsOneWidget);
      expect(rulesButton, findsOneWidget);
    });
  });
}