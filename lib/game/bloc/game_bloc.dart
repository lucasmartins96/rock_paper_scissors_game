import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/images_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/widget_keys_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/models/game_pick.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitialState(gameInitialPicks)) {
    on<GameStartedEvent>(_onStarted);
    on<GameUserPickedEvent>(_onUserPick);
    on<GameHomePickedEvent>(_onHomePick);
    on<GameFinishedEvent>(_onFinished);
  }

  static final List<GamePick> gameInitialPicks = [
    GamePick(
      name: PlayerGamePick.paper,
      iconPath: ImagesConstants.icons.paper,
      gradientBorderFirstColor: ColorsConstants.gradient.paper.color.shade300,
      gradientBorderSecondColor: ColorsConstants.gradient.paper.color.shade400,
      buttonKey: WidgetKeysConstants.gamePickPaperButton,
    ),
    GamePick(
      name: PlayerGamePick.scissor,
      iconPath: ImagesConstants.icons.scissor,
      gradientBorderFirstColor:
          ColorsConstants.gradient.scissors.color.shade400,
      gradientBorderSecondColor:
          ColorsConstants.gradient.scissors.color.shade500,
      buttonKey: WidgetKeysConstants.gamePickScissorButton,
    ),
    GamePick(
      name: PlayerGamePick.rock,
      iconPath: ImagesConstants.icons.rock,
      gradientBorderFirstColor: ColorsConstants.gradient.rock.color.shade400,
      gradientBorderSecondColor: ColorsConstants.gradient.rock.color.shade500,
      buttonKey: WidgetKeysConstants.gamePickRockButton,
    ),
  ];

  void _onStarted(GameStartedEvent event, Emitter<GameState> emit) {
    emit(GameInitialState(gameInitialPicks));
  }

  void _onUserPick(GameUserPickedEvent event, Emitter<GameState> emit) {
    emit(UserPickState(event.userPick));
  }

  void _onHomePick(GameHomePickedEvent event, Emitter<GameState> emit) {
    final userPick = event.userPick;
    var homePick = _getHomeGamePick();

    while (userPick.name.code == homePick.name.code) {
      homePick = _getHomeGamePick();
    }

    emit(HomePickState(userGamePick: userPick, homeGamePick: homePick));
  }

  GamePick _getHomeGamePick() {
    const picks = 3;
    const maxRange = 10;
    final randomNumber = Random().nextInt(maxRange) % picks;
    return gameInitialPicks.elementAt(randomNumber);
  }

  void _onFinished(GameFinishedEvent event, Emitter<GameState> emit) {
    final playerGamePick =
        _getWinnerPick(event.userPick.name, event.homePick.name);
    final winnerPick = gameInitialPicks
        .singleWhere((gamePick) => playerGamePick == gamePick.name);

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
