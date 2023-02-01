import 'package:flutter/material.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_button/game_pick_button.dart';

class GamePickButtonDopplerBorder extends StatelessWidget {
  const GamePickButtonDopplerBorder({
    super.key,
    required this.pickImagePath,
    required this.gradientFirstColor,
    required this.gradientSecondColor,
  });

  final String pickImagePath;
  final Color gradientFirstColor;
  final Color gradientSecondColor;

  @override
  Widget build(BuildContext context) {
    return lastDopplerTier();
  }

  Container lastDopplerTier() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.03),
      ),
      child: _secondDopplerTier(),
    );
  }

  Container _secondDopplerTier() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.03),
      ),
      child: _firstDopplerTier(),
    );
  }

  Container _firstDopplerTier() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.03),
      ),
      child: GamePickButton(
        pickImagePath: pickImagePath,
        gradientFirstColor: gradientFirstColor,
        gradientSecondColor: gradientSecondColor,
      ),
    );
  }
}
