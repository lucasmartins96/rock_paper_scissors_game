import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum PlayerGamePicks { paper, rock, scissor }

class GamePick extends Equatable {
  const GamePick({
    required this.pick,
    required this.iconPath,
    required this.gradientBorderFirstColor,
    required this.gradientBorderSecondColor,
    this.buttonKey,
  });

  final PlayerGamePicks pick;
  final String iconPath;
  final Color gradientBorderFirstColor;
  final Color gradientBorderSecondColor;
  final Key? buttonKey;

  @override
  List<Object?> get props => [pick.name];
}
