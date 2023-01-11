import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePick extends Equatable {
  const GamePick({
    required this.name,
    required this.iconPath,
    required this.gradientBorderFirstColor,
    required this.gradientBorderSecondColor,
  });

  final PlayerGamePick name;
  final String iconPath;
  final Color gradientBorderFirstColor;
  final Color gradientBorderSecondColor;

  @override
  List<Object?> get props => [name];
}
