import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  static const double circleSize = 108;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradientFirstColor, gradientSecondColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(pickImagePath),
          ),
        ),
      ),
    );
  }
}
