import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_button/game_pick_button_base.dart';

class GameEmptyPick extends StatefulWidget {
  const GameEmptyPick() : super(key: WidgetKeysConstants.emptyPick);

  @override
  State<GameEmptyPick> createState() => _GameEmptyPickState();
}

class _GameEmptyPickState extends State<GameEmptyPick> {
  double circleSize = 310;

  @override
  Widget build(BuildContext context) {
    _handleCircleSize();

    return GamePickButtonBase(
      containerBorderDecoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      containerPickImageDecoration: BoxDecoration(
        color: ColorsConstants.gradient.background.color.shade900,
        shape: BoxShape.circle,
      ),
      circleSize: circleSize,
    );
  }

  void _handleCircleSize() {
    final width = MediaQuery.of(context).size.width;

    if (width <= 1300 && circleSize == 310) {
      setState(() {
        circleSize = 260;
      });
    } else if (width <= 1200 && circleSize == 260) {
      setState(() {
        circleSize = 210;
      });
    } else if (width <= 1000 && circleSize == 210) {
      setState(() {
        circleSize = 160;
      });
    }
  }
}
