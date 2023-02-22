part of 'game_bloc.dart';

enum GameStatus { start, progress, finish }

// @immutable
class GameState extends Equatable {
  const GameState({
    this.gamePicks = const [],
    this.userPick,
    this.homePick,
    this.isUserWin,
    this.status = GameStatus.start,
  });

  final List<GamePick> gamePicks;
  final GamePick? userPick;
  final GamePick? homePick;
  final bool? isUserWin;
  final GameStatus status;

  GameState copyWith({
    List<GamePick>? gamePicks,
    GamePick? userPick,
    GamePick? homePick,
    bool? isUserWin,
    GameStatus? status,
  }) {
    return GameState(
      gamePicks: gamePicks ?? this.gamePicks,
      userPick: userPick ?? this.userPick,
      homePick: homePick ?? this.homePick,
      isUserWin: isUserWin ?? this.isUserWin,
      status: status ?? this.status,
    );
  }

  GameState reset() => GameState(gamePicks: gamePicks);

  @override
  List<Object?> get props => [
        gamePicks,
        userPick?.pick.name,
        homePick?.pick.name,
        isUserWin,
        status,
      ];
}
