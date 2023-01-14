import 'package:flutter/material.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';

class GameEmptyPick extends StatelessWidget {
  const GameEmptyPick({super.key});

  static const double circleSize = 128;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorsConstants.gradient.background.color.shade900,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
