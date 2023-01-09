import 'package:flutter/material.dart';

class GamePick extends StatelessWidget {
  const GamePick({
    super.key,
    this.pickImagePath,
    this.gradientFirstColor,
    this.gradientSecondColor,
    this.action,
  });

  final String? pickImagePath;
  final Color? gradientFirstColor;
  final Color? gradientSecondColor;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(),
    );
  }
}
