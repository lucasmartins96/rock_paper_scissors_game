part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameStartedEvent extends GameEvent {}

class GameUserPickedEvent extends GameEvent {
  GameUserPickedEvent(this.userPick);

  final PlayerGamePick userPick;
}

class GameHomePickedEvent extends GameEvent {
  GameHomePickedEvent(this.userPick);

  final PlayerGamePick userPick;
}

class GameFinishedEvent extends GameEvent {
  GameFinishedEvent({
    required this.userPick,
    required this.homePick,
  });

  final PlayerGamePick userPick;
  final PlayerGamePick homePick;
}
