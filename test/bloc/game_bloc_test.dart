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
    late GameRepository repository;

    setUpAll(() {
      repository = MockRepository();
    });

    test('initial state is GameInitialState', () {
      expect(GameBloc(gameRepository: repository).state, const GameState());
    });

    group('GameStartedEvent', () {
      blocTest<GameBloc, GameState>(
        'emits [GameState] with picks not empty '
        'when GameStartedEvent is added.',
        setUp: () {
          when(() => repository.getAllPicks()).thenReturn(mockPicks);
        },
        build: () => GameBloc(gameRepository: repository),
        act: (bloc) => bloc.add(GameStartedEvent()),
        expect: () => const [GameState(gamePicks: mockPicks)],
        verify: (_) {
          verify(() => repository.getAllPicks()).called(1);
        },
      );

      blocTest<GameBloc, GameState>(
        'emits [GameState] reset when GameStartedEvent is added.',
        build: () => GameBloc(gameRepository: repository),
        seed: () => const GameState(
          gamePicks: mockPicks,
          userPick: paperPlayerPick,
          homePick: rockPlayerPick,
          isUserWin: true,
          status: GameStatus.finish,
        ),
        act: (bloc) => bloc.add(GameStartedEvent()),
        expect: () => const [GameState(gamePicks: mockPicks)],
      );
    });

    group('GameUserPickedEvent', () {
      blocTest<GameBloc, GameState>(
        'emits [GameState] with userPick filled and status in progress '
        'when GameUserPickedEvent is added with user pick.',
        build: () => GameBloc(gameRepository: repository),
        seed: () => const GameState(gamePicks: mockPicks),
        act: (bloc) => bloc.add(GameUserPickedEvent(paperPlayerPick)),
        expect: () => const [
          GameState(
            gamePicks: mockPicks,
            userPick: paperPlayerPick,
            status: GameStatus.progress,
          )
        ],
      );
    });

    group('GameHomePickedEvent', () {
      blocTest<GameBloc, GameState>(
        'emits [GameState] with homePick value other than userPick value '
        'and status in progress '
        'when GameHomePickedEvent is added and user pick value is "paper".',
        build: () => GameBloc(gameRepository: repository),
        seed: () => const GameState(
          gamePicks: mockPicks,
          userPick: paperPlayerPick,
          status: GameStatus.progress,
        ),
        act: (bloc) => bloc.add(GameHomePickedEvent()),
        expect: () => [
          anyOf(
            const GameState(
              gamePicks: mockPicks,
              userPick: paperPlayerPick,
              homePick: scissorPlayerPick,
              status: GameStatus.progress,
            ),
            const GameState(
              gamePicks: mockPicks,
              userPick: paperPlayerPick,
              homePick: rockPlayerPick,
              status: GameStatus.progress,
            ),
          ),
        ],
      );

      blocTest<GameBloc, GameState>(
        'emits [GameState] with homePick value other than userPick value '
        'and status in progress '
        'when GameHomePickedEvent is added and user pick value is "rock".',
        build: () => GameBloc(gameRepository: repository),
        seed: () => const GameState(
          gamePicks: mockPicks,
          userPick: rockPlayerPick,
          status: GameStatus.progress,
        ),
        act: (bloc) => bloc.add(GameHomePickedEvent()),
        expect: () => [
          anyOf(
            const GameState(
              gamePicks: mockPicks,
              userPick: rockPlayerPick,
              homePick: scissorPlayerPick,
              status: GameStatus.progress,
            ),
            const GameState(
              gamePicks: mockPicks,
              userPick: rockPlayerPick,
              homePick: paperPlayerPick,
              status: GameStatus.progress,
            ),
          ),
        ],
      );

      blocTest<GameBloc, GameState>(
        'emits [GameState] with homePick value other than userPick value '
        'and status in progress '
        'when GameHomePickedEvent is added and user pick value is "scissor".',
        build: () => GameBloc(gameRepository: repository),
        seed: () => const GameState(
          gamePicks: mockPicks,
          userPick: scissorPlayerPick,
          status: GameStatus.progress,
        ),
        act: (bloc) => bloc.add(GameHomePickedEvent()),
        expect: () => [
          anyOf(
            const GameState(
              gamePicks: mockPicks,
              userPick: scissorPlayerPick,
              homePick: paperPlayerPick,
              status: GameStatus.progress,
            ),
            const GameState(
              gamePicks: mockPicks,
              userPick: scissorPlayerPick,
              homePick: rockPlayerPick,
              status: GameStatus.progress,
            ),
          ),
        ],
      );
    });

    group('GameFinishedEvent', () {
      group(
        'emits [GameState] with isUserWin=true and status finished '
        'when GameFinishedEvent is added',
        () {
          blocTest<GameBloc, GameState>(
            'and user pick value is "paper"',
            build: () => GameBloc(gameRepository: repository),
            seed: () => const GameState(
              gamePicks: mockPicks,
              userPick: paperPlayerPick,
              homePick: rockPlayerPick,
              status: GameStatus.progress,
            ),
            act: (bloc) => bloc.add(GameFinishedEvent()),
            expect: () => const [
              GameState(
                gamePicks: mockPicks,
                userPick: paperPlayerPick,
                homePick: rockPlayerPick,
                status: GameStatus.finish,
                isUserWin: true,
              )
            ],
          );

          blocTest<GameBloc, GameState>(
            'and user pick value is "rock"',
            build: () => GameBloc(gameRepository: repository),
            seed: () => const GameState(
              gamePicks: mockPicks,
              userPick: rockPlayerPick,
              homePick: scissorPlayerPick,
              status: GameStatus.progress,
            ),
            act: (bloc) => bloc.add(GameFinishedEvent()),
            expect: () => const [
              GameState(
                gamePicks: mockPicks,
                userPick: rockPlayerPick,
                homePick: scissorPlayerPick,
                status: GameStatus.finish,
                isUserWin: true,
              )
            ],
          );

          blocTest<GameBloc, GameState>(
            'and user pick value is "scissor"',
            build: () => GameBloc(gameRepository: repository),
            seed: () => const GameState(
              gamePicks: mockPicks,
              userPick: scissorPlayerPick,
              homePick: paperPlayerPick,
              status: GameStatus.progress,
            ),
            act: (bloc) => bloc.add(GameFinishedEvent()),
            expect: () => const [
              GameState(
                gamePicks: mockPicks,
                userPick: scissorPlayerPick,
                homePick: paperPlayerPick,
                status: GameStatus.finish,
                isUserWin: true,
              )
            ],
          );
        },
      );

      group(
        'emits [GameState] with isUserWin=false and status finished '
        'when GameFinishedEvent is added',
        () {
          blocTest<GameBloc, GameState>(
            'and user pick value is "paper"',
            build: () => GameBloc(gameRepository: repository),
            seed: () => const GameState(
              gamePicks: mockPicks,
              userPick: paperPlayerPick,
              homePick: scissorPlayerPick,
              status: GameStatus.progress,
            ),
            act: (bloc) => bloc.add(GameFinishedEvent()),
            expect: () => const [
              GameState(
                gamePicks: mockPicks,
                userPick: paperPlayerPick,
                homePick: scissorPlayerPick,
                status: GameStatus.finish,
                isUserWin: false,
              )
            ],
          );

          blocTest<GameBloc, GameState>(
            'and user pick value is "rock"',
            build: () => GameBloc(gameRepository: repository),
            seed: () => const GameState(
              gamePicks: mockPicks,
              userPick: rockPlayerPick,
              homePick: paperPlayerPick,
              status: GameStatus.progress,
            ),
            act: (bloc) => bloc.add(GameFinishedEvent()),
            expect: () => const [
              GameState(
                gamePicks: mockPicks,
                userPick: rockPlayerPick,
                homePick: paperPlayerPick,
                status: GameStatus.finish,
                isUserWin: false,
              )
            ],
          );

          blocTest<GameBloc, GameState>(
            'and user pick value is "scissor"',
            build: () => GameBloc(gameRepository: repository),
            seed: () => const GameState(
              gamePicks: mockPicks,
              userPick: scissorPlayerPick,
              homePick: rockPlayerPick,
              status: GameStatus.progress,
            ),
            act: (bloc) => bloc.add(GameFinishedEvent()),
            expect: () => const [
              GameState(
                gamePicks: mockPicks,
                userPick: scissorPlayerPick,
                homePick: rockPlayerPick,
                status: GameStatus.finish,
                isUserWin: false,
              )
            ],
          );
        },
      );
    });
  });
}
