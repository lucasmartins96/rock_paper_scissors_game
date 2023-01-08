import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameInitialState()) {
    on<GameStartedEvent>(_onStarted);
    on<GameUserPickedEvent>(_onUserPick);
    on<GameHomePickedEvent>(_onHomePick);
    on<GameFinishedEvent>(_onFinished);
  }

  void _onStarted(GameStartedEvent event, Emitter<GameState> emit) {
    emit(const GameInitialState());
  }

  void _onUserPick(GameUserPickedEvent event, Emitter<GameState> emit) {
    emit(UserPickState(event.userPick));
  }

  void _onHomePick(GameHomePickedEvent event, Emitter<GameState> emit) {
    final userPick = event.userPick;
    var homePick = _getHomeGamePick();

    while (userPick.code == homePick.code) {
      homePick = _getHomeGamePick();
    }

    emit(HomePickState(homePick));
  }

  PlayerGamePick _getHomeGamePick() {
    const picks = 3;
    const maxRange = 10;
    final randomNumber = Random().nextInt(maxRange) % picks;
    return PlayerGamePick.getByCode(randomNumber);
  }

  void _onFinished(GameFinishedEvent event, Emitter<GameState> emit) {
    final winnerPick = _getWinnerPick(event.userPick, event.homePick);
    emit(GameFinishState(winnerPick));
  }

  PlayerGamePick _getWinnerPick(
    PlayerGamePick userPick,
    PlayerGamePick homePick,
  ) {
    const userPickWeight = 1;
    var homePickWeight = 0;

    switch (userPick) {
      case PlayerGamePick.paper:
        homePickWeight = homePick == PlayerGamePick.scissor ? 2 : 0;
        break;
      case PlayerGamePick.rock:
        homePickWeight = homePick == PlayerGamePick.paper ? 2 : 0;
        break;
      case PlayerGamePick.scissor:
        homePickWeight = homePick == PlayerGamePick.rock ? 2 : 0;
        break;
    }

    return userPickWeight > homePickWeight ? userPick : homePick;
  }
}
