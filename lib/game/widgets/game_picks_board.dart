import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePicksBoard extends StatefulWidget {
  const GamePicksBoard({super.key, required this.gamePicks});

  final List<GamePick> gamePicks;

  @override
  State<GamePicksBoard> createState() => _GamePicksBoardState();
}

class _GamePicksBoardState extends State<GamePicksBoard> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutProvider.of(context).isDesktop;
    final heightViewport = MediaQuery.of(context).size.height;

    if (widget.gamePicks.isEmpty) {
      return const SizedBox();
    }

    final topLeftPick = widget.gamePicks[0];
    final topRightPick = widget.gamePicks[1];
    final bottomCenterPick = widget.gamePicks[2];
    final paddingTop = isDesktop ? (heightViewport * 0.2) : 0.0;
    final boardWidth = isDesktop ? 500.0 : 300.0;
    final boardHeight = isDesktop ? 450.0 : 300.0;
    final triangleContainerWidth = isDesktop ? boardWidth : 200.0;
    final triangleContainerHeight = isDesktop ? (boardHeight - 200.0) : 200.0;

    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: SizedBox(
        width: boardWidth,
        height: boardHeight,
        child: SizedBox(
          child: Stack(
            children: [
              Align(
                child: SizedBox(
                  width: triangleContainerWidth,
                  height: triangleContainerHeight,
                  child: SvgPicture.asset(ImagesConstants.bgTriangle),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: _buildPickButton(topLeftPick),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _buildPickButton(topRightPick),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildPickButton(bottomCenterPick),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickButton(GamePick gamePick) {
    final isDesktop = LayoutProvider.of(context).isDesktop;
    final gamePickButtonSize = isDesktop ? 200.0 : null;

    return GamePickButton(
      key: gamePick.buttonKey,
      pickImagePath: gamePick.iconPath,
      gradientFirstColor: gamePick.gradientBorderFirstColor,
      gradientSecondColor: gamePick.gradientBorderSecondColor,
      circleSize: gamePickButtonSize,
      action: () {
        _setUserPick(gamePick);
      },
    );
  }

  void _setUserPick(GamePick userPick) {
    context.read<GameBloc>().add(GameUserPickedEvent(userPick));
  }
}
