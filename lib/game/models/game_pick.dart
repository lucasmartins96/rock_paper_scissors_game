import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePick extends Equatable {
  const GamePick({
    required this.name,
    required this.iconPath,
    required this.gradientBorderFirstColor,
    required this.gradientBorderSecondColor,
    this.buttonKey,
  });

  final PlayerGamePick name;
  final String iconPath;
  final Color gradientBorderFirstColor;
  final Color gradientBorderSecondColor;
  final Key? buttonKey;

  @override
  List<Object?> get props => [name.name];
}
