part of 'game_bloc.dart';

enum GameStatus { start, progress, finish }

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
  const GameFinishState({
    required this.userGamePick,
    required this.homeGamePick,
    required this.isUserWin,
  }) : super(null);

  final GamePick userGamePick;
  final GamePick homeGamePick;
  final bool isUserWin;
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
