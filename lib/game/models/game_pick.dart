import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum PlayerGamePicks { paper, rock, scissor }

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
