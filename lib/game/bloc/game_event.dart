part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameStartedEvent extends GameEvent {}

class GameUserPickedEvent extends GameEvent {
  GameUserPickedEvent(this.userPick);

  final GamePick userPick;
}

class GameHomePickedEvent extends GameEvent {}

class GameFinishedEvent extends GameEvent {}
