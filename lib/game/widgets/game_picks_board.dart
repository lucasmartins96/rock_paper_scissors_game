import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePicksBoard extends StatelessWidget {
  const GamePicksBoard({super.key, required this.gamePicks});

  final List<GamePick> gamePicks;

  @override
  Widget build(BuildContext context) {
    if (gamePicks.isEmpty) {
      return const SizedBox();
    }

    final topLeftPick = gamePicks[0];
    final topRightPick = gamePicks[1];
    final bottomCenterPick = gamePicks[2];

    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Align(
            child: SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset(ImagesConstants.bgTriangle),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GamePickButton(
              key: topLeftPick.buttonKey,
              pickImagePath: topLeftPick.iconPath,
              gradientFirstColor: topLeftPick.gradientBorderFirstColor,
              gradientSecondColor: topLeftPick.gradientBorderSecondColor,
              action: () {
                _setUserPick(context, userPick: topLeftPick);
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GamePickButton(
              key: topRightPick.buttonKey,
              pickImagePath: topRightPick.iconPath,
              gradientFirstColor: topRightPick.gradientBorderFirstColor,
              gradientSecondColor: topRightPick.gradientBorderSecondColor,
              action: () {
                _setUserPick(context, userPick: topRightPick);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GamePickButton(
              key: bottomCenterPick.buttonKey,
              pickImagePath: bottomCenterPick.iconPath,
              gradientFirstColor: bottomCenterPick.gradientBorderFirstColor,
              gradientSecondColor: bottomCenterPick.gradientBorderSecondColor,
              action: () {
                _setUserPick(context, userPick: bottomCenterPick);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setUserPick(BuildContext context, {required GamePick userPick}) {
    context.read<GameBloc>().add(GameUserPickedEvent(userPick));
  }
}
