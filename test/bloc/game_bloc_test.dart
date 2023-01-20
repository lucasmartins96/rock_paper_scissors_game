import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements GameRepositoryStatic {}

void main() {
  const paperPlayerPick = GamePick(
    pick: PlayerGamePicks.paper,
    iconPath: '',
    gradientBorderFirstColor: Colors.black,
    gradientBorderSecondColor: Colors.white,
  );
  const rockPlayerPick = GamePick(
    pick: PlayerGamePicks.rock,
    iconPath: '',
    gradientBorderFirstColor: Colors.black,
    gradientBorderSecondColor: Colors.white,
  );
  const scissorPlayerPick = GamePick(
    pick: PlayerGamePicks.scissor,
    iconPath: '',
    gradientBorderFirstColor: Colors.black,
    gradientBorderSecondColor: Colors.white,
  );
  const mockPicks = [paperPlayerPick, rockPlayerPick, scissorPlayerPick];

  group('GameBloc', () {
    test('initial state is GameInitialState', () {
      expect(GameBloc().state, const GameInitialState(mockPicks));
    });

    blocTest<GameBloc, GameState>(
      'emits [GameInitialState] after dispatch GameStartedEvent',
      build: GameBloc.new,
      act: (bloc) => bloc.add(GameStartedEvent()),
      expect: () => [const GameInitialState(mockPicks)],
    );

    blocTest<GameBloc, GameState>(
      'emits [UserPickState(PlayerGamePick.paper)] '
      'after dispatch GameUserPickedEvent(PlayerGamePick.paper)',
      build: GameBloc.new,
      act: (bloc) => bloc.add(GameUserPickedEvent(paperPlayerPick)),
      expect: () => [const UserPickState(paperPlayerPick)],
    );

    group('GameHomePickedEvent', () {
      blocTest<GameBloc, GameState>(
        'emits [HomePickState(PlayerGamePick.rock)] '
        'or [HomePickState(PlayerGamePick.paper)] '
        'after dispatch GameHomePickedEvent(PlayerGamePick.scissor)',
        build: GameBloc.new,
        act: (bloc) => bloc.add(GameHomePickedEvent(scissorPlayerPick)),
        expect: () => [
          anyOf(
            const HomePickState(rockPlayerPick),
            const HomePickState(paperPlayerPick),
          )
        ],
      );

      blocTest<GameBloc, GameState>(
        'emits [HomePickState(PlayerGamePick.rock)] '
        'or [HomePickState(PlayerGamePick.scissor)] '
        'after dispatch GameHomePickedEvent(PlayerGamePick.paper)',
        build: GameBloc.new,
        act: (bloc) => bloc.add(GameHomePickedEvent(paperPlayerPick)),
        expect: () => [
          anyOf(
            const HomePickState(scissorPlayerPick),
            const HomePickState(rockPlayerPick),
          )
        ],
      );

      blocTest<GameBloc, GameState>(
        'emits [HomePickState(PlayerGamePick.scissor)] '
        'or [HomePickState(PlayerGamePick.paper)] '
        'after dispatch GameHomePickedEvent(PlayerGamePick.rock)',
        build: GameBloc.new,
        act: (bloc) => bloc.add(GameHomePickedEvent(rockPlayerPick)),
        expect: () => [
          anyOf(
            const HomePickState(scissorPlayerPick),
            const HomePickState(paperPlayerPick),
          )
        ],
      );

      blocTest<GameBloc, GameState>(
        'not emits [GameHomePickedEvent(PlayerGamePick.rock)] '
        'after dispatch GameHomePickedEvent(PlayerGamePick.rock)',
        build: GameBloc.new,
        act: (bloc) => bloc.add(GameHomePickedEvent(rockPlayerPick)),
        expect: () => [isNot(const HomePickState(rockPlayerPick))],
      );

      blocTest<GameBloc, GameState>(
        'not emits [HomePickState(PlayerGamePick.paper)] '
        'after dispatch GameHomePickedEvent(PlayerGamePick.paper)',
        build: GameBloc.new,
        act: (bloc) => bloc.add(GameHomePickedEvent(paperPlayerPick)),
        expect: () => [isNot(const HomePickState(paperPlayerPick))],
      );

      blocTest<GameBloc, GameState>(
        'not emits [HomePickState(PlayerGamePick.scissor)] '
        'after dispatch GameHomePickedEvent(PlayerGamePick.scissor)',
        build: GameBloc.new,
        act: (bloc) => bloc.add(GameHomePickedEvent(scissorPlayerPick)),
        expect: () => [isNot(const HomePickState(scissorPlayerPick))],
      );
    });

    group('GameFinishedEvent', () {
      group('emits [GameFinishState(PlayerGamePick.rock)]', () {
        blocTest<GameBloc, GameState>(
          'when user pick "rock" and home pick "scissor"',
          build: GameBloc.new,
          act: (bloc) => bloc.add(
            GameFinishedEvent(
              userPick: rockPlayerPick,
              homePick: scissorPlayerPick,
            ),
          ),
          expect: () => [const GameFinishState(rockPlayerPick)],
        );

        blocTest<GameBloc, GameState>(
          'when user pick "scissor" and home pick "rock"',
          build: GameBloc.new,
          act: (bloc) => bloc.add(
            GameFinishedEvent(
              userPick: scissorPlayerPick,
              homePick: rockPlayerPick,
            ),
          ),
          expect: () => [const GameFinishState(rockPlayerPick)],
        );
      });

      group('emits [GameFinishState(PlayerGamePick.paper)]', () {
        blocTest<GameBloc, GameState>(
          'when user pick "paper" and home pick "rock"',
          build: GameBloc.new,
          act: (bloc) => bloc.add(
            GameFinishedEvent(
              userPick: paperPlayerPick,
              homePick: rockPlayerPick,
            ),
          ),
          expect: () => [const GameFinishState(paperPlayerPick)],
        );

        blocTest<GameBloc, GameState>(
          'when user pick "rock" and home pick "paper"',
          build: GameBloc.new,
          act: (bloc) => bloc.add(
            GameFinishedEvent(
              userPick: rockPlayerPick,
              homePick: paperPlayerPick,
            ),
          ),
          expect: () => [const GameFinishState(paperPlayerPick)],
        );
      });

      group('emits [GameFinishState(PlayerGamePick.scissor)]', () {
        blocTest<GameBloc, GameState>(
          'when user pick "scissor" and home pick "paper"',
          build: GameBloc.new,
          act: (bloc) => bloc.add(
            GameFinishedEvent(
              userPick: scissorPlayerPick,
              homePick: paperPlayerPick,
            ),
          ),
          expect: () => [const GameFinishState(scissorPlayerPick)],
        );

        blocTest<GameBloc, GameState>(
          'when user pick "paper" and home pick "scissor"',
          build: GameBloc.new,
          act: (bloc) => bloc.add(
            GameFinishedEvent(
              userPick: paperPlayerPick,
              homePick: scissorPlayerPick,
            ),
          ),
          expect: () => [const GameFinishState(scissorPlayerPick)],
        );
      });
    });
  });
}
