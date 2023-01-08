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

  final PlayerGamePick? playerGamePick;

  @override
  List<Object?> get props => [playerGamePick];
}

class GameInitialState extends GameState {
  const GameInitialState() : super(null);
}

class UserPickState extends GameState {
  const UserPickState(this.playerPick) : super(playerPick);

  final PlayerGamePick playerPick;
}

class HomePickState extends GameState {
  const HomePickState(this.playerPick) : super(playerPick);

  final PlayerGamePick playerPick;
}

class GameFinishState extends GameState {
  const GameFinishState(this.winnerPick) : super(winnerPick);

  final PlayerGamePick winnerPick;
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
