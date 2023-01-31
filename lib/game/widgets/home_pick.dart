import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class HomePick extends StatelessWidget {
  const HomePick({super.key, this.homePick});

  final GamePick? homePick;

  @override
  Widget build(BuildContext context) {
    return homePick != null
        ? GamePickButtonInvisiblePadding(
            gamePickButton: GamePickButton(
              key: homePick!.buttonKey,
              pickImagePath: homePick!.iconPath,
              gradientFirstColor: homePick!.gradientBorderFirstColor,
              gradientSecondColor: homePick!.gradientBorderSecondColor,
            ),
          )
        : const GameEmptyPick();
  }
}
