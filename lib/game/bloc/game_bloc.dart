import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({GameRepository? gameRepository})
      : _gameRepository = gameRepository ?? GameRepositoryStatic(),
        super(const GameState()) {
    on<GameStartedEvent>(_onStarted);
    on<GameUserPickedEvent>(_onUserPick);
    on<GameHomePickedEvent>(_onHomePick);
    on<GameFinishedEvent>(_onFinished);
  }

  final GameRepository _gameRepository;

  void _onStarted(GameStartedEvent event, Emitter<GameState> emit) {
    if (state.status == GameStatus.finish) {
      return emit(state.reset());
    }

    final initialPicks = _gameRepository.getAllPicks();
    emit(state.copyWith(gamePicks: initialPicks));
  }

  void _onUserPick(GameUserPickedEvent event, Emitter<GameState> emit) {
    emit(
      state.copyWith(userPick: event.userPick, status: GameStatus.progress),
    );
  }

  void _onHomePick(GameHomePickedEvent event, Emitter<GameState> emit) {
    final userPick = state.userPick;
    var homePick = _getHomeGamePick();

    while (userPick == homePick) {
      homePick = _getHomeGamePick();
    }

    emit(state.copyWith(homePick: homePick));
  }

  GamePick _getHomeGamePick() {
    const picks = 3;
    const maxRange = 10;
    final randomNumber = Random().nextInt(maxRange) % picks;
    return state.gamePicks.elementAt(randomNumber);
  }

  void _onFinished(GameFinishedEvent event, Emitter<GameState> emit) {
    final playerGamePick =
        _getWinnerPick(event.userPick.pick, event.homePick.pick);
    final winnerPick = gameInitialPicks
        .singleWhere((gamePick) => playerGamePick == gamePick.pick);

    final isUserWin = winnerPick == event.userPick;

    emit(
      GameFinishState(
        userGamePick: event.userPick,
        homeGamePick: event.homePick,
        isUserWin: isUserWin,
      ),
    );
  }

  PlayerGamePicks _getWinnerPick(
    PlayerGamePicks userPick,
    PlayerGamePicks homePick,
  ) {
    const userPickWeight = 1;
    var homePickWeight = 0;

    switch (userPick) {
      case PlayerGamePicks.paper:
        homePickWeight = homePick == PlayerGamePicks.scissor ? 2 : 0;
        break;
      case PlayerGamePicks.rock:
        homePickWeight = homePick == PlayerGamePicks.paper ? 2 : 0;
        break;
      case PlayerGamePicks.scissor:
        homePickWeight = homePick == PlayerGamePicks.rock ? 2 : 0;
        break;
    }

    return userPickWeight > homePickWeight ? userPick : homePick;
  }
}
