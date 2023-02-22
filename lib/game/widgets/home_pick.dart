import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class HomePick extends StatelessWidget {
  const HomePick({super.key, this.homePick});

  final GamePick? homePick;

  @override
  Widget build(BuildContext context) {
    const circleSize = 300.0;

    return homePick != null
        ? GamePickButton(
            key: homePick!.buttonKey,
            pickImagePath: homePick!.iconPath,
            gradientFirstColor: homePick!.gradientBorderFirstColor,
            gradientSecondColor: homePick!.gradientBorderSecondColor,
            circleSize: circleSize,
          )
        : const GameEmptyPick();
  }
}
