import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePickButtonDopplerBorder extends StatefulWidget {
  const GamePickButtonDopplerBorder({
    super.key,
    required this.pickImagePath,
    required this.gradientFirstColor,
    required this.gradientSecondColor,
    this.circleSize,
  });

  final String pickImagePath;
  final Color gradientFirstColor;
  final Color gradientSecondColor;
  final double? circleSize;

  @override
  State<GamePickButtonDopplerBorder> createState() =>
      _GamePickButtonDopplerBorderState();
}

class _GamePickButtonDopplerBorderState
    extends State<GamePickButtonDopplerBorder> {
  double lastDopplerTierPadding = 85;
  double secondDopplerTierPadding = 65;
  double firstDopplerTierPadding = 65;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width <= 900 && lastDopplerTierPadding == 85) {
      setState(() {
        lastDopplerTierPadding = 65;
        secondDopplerTierPadding = 55;
        firstDopplerTierPadding = 55;
      });
    } else if (width <= 800 && lastDopplerTierPadding == 65) {
      setState(() {
        lastDopplerTierPadding = 32;
        secondDopplerTierPadding = 28;
        firstDopplerTierPadding = 24;
      });
    }

    return lastDopplerTier();
  }

  Container lastDopplerTier() {
    return Container(
      padding: EdgeInsets.all(lastDopplerTierPadding),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.03),
      ),
      child: _secondDopplerTier(),
    );
  }

  Container _secondDopplerTier() {
    return Container(
      padding: EdgeInsets.all(secondDopplerTierPadding),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.03),
      ),
      child: _firstDopplerTier(),
    );
  }

  Container _firstDopplerTier() {
    return Container(
      padding: EdgeInsets.all(firstDopplerTierPadding),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.03),
      ),
      child: GamePickButton(
        pickImagePath: widget.pickImagePath,
        gradientFirstColor: widget.gradientFirstColor,
        gradientSecondColor: widget.gradientSecondColor,
        circleSize: widget.circleSize,
      ),
    );
  }
}
