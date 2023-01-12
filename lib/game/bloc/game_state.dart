part of 'game_bloc.dart';

enum PlayerGamePick {
  paper(0, 'paper'),
  rock(1, 'rock'),
  scissor(2, 'scissor');

  const PlayerGamePick(this.code, this.name);

  final int code;
  final String name;

  static PlayerGamePick getByCode(int code) {
    return PlayerGamePick.values
        .firstWhere((gamePick) => gamePick.code == code);
  }
}

@immutable
abstract class GameState extends Equatable {
  const GameState(this.playerGamePick);

  final GamePick? playerGamePick;

  @override
  List<Object?> get props => [playerGamePick];
}

class GameInitialState extends GameState {
  const GameInitialState(this.gameInitialPicks) : super(null);

  final List<GamePick> gameInitialPicks;
}

class UserPickState extends GameState {
  const UserPickState(super.playerGamePick);
}

class HomePickState extends GameState {
  const HomePickState({required this.userGamePick, required this.homeGamePick})
      : super(null);

  final GamePick userGamePick;
  final GamePick homeGamePick;
}

class GameFinishState extends GameState {
  const GameFinishState(super.playerGamePick);
}

// class GameHousePicked extends GameState {}

// class GameComplete extends GameState {}

/*

class GameState extends Equatable {
  final GameStatus status;
  final PlayerGamePick userPick;
  final PlayerGamePick homePick;
  

  @override
  List<Object?> get props => throw UnimplementedError();
} */

/* 
  initial
  userPick
  homePick
 */
