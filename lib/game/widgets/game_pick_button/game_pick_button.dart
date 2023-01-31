import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_button/game_pick_button_base.dart';

class GamePickButton extends StatelessWidget {
  const GamePickButton({
    super.key,
    required this.pickImagePath,
    required this.gradientFirstColor,
    required this.gradientSecondColor,
    this.action,
  });

  final String pickImagePath;
  final Color gradientFirstColor;
  final Color gradientSecondColor;
  final VoidCallback? action;
  static const double circleSize = 128;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: GamePickButtonBase(
        containerBorderDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientFirstColor, gradientSecondColor],
          ),
          shape: BoxShape.circle,
        ),
        containerPickImageDecoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        pickImage: SvgPicture.asset(pickImagePath),
      ),
    );
  }
}
