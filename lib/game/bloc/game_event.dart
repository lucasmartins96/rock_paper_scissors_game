part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameStartedEvent extends GameEvent {}

class GameUserPickedEvent extends GameEvent {
  GameUserPickedEvent(this.userPick);

  final GamePick userPick;
}

class GameHomePickedEvent extends GameEvent {
  GameHomePickedEvent(this.userPick);

  final GamePick userPick;
}

class GameFinishedEvent extends GameEvent {
  GameFinishedEvent({
    required this.userPick,
    required this.homePick,
  });

  final GamePick userPick;
  final GamePick homePick;
}
