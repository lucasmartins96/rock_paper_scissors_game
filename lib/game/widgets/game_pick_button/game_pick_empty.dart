import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_button/game_pick_button_base.dart';

class GameEmptyPick extends StatefulWidget {
  const GameEmptyPick() : super(key: WidgetKeysConstants.emptyPick);

  @override
  State<GameEmptyPick> createState() => _GameEmptyPickState();
}

class _GameEmptyPickState extends State<GameEmptyPick> {
  @override
  Widget build(BuildContext context) {
    final circleSize = _handleCircleSize();

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

  double _handleCircleSize() {
    final width = MediaQuery.of(context).size.width;
    var circleSize = 310.0;

    if (width > 1200 && width <= 1300) {
      circleSize = 260;
    } else if (width > 1000 && width <= 1200) {
      circleSize = 210;
    } else if (width > 800 && width <= 1000) {
      circleSize = 160;
    } else if (width <= 800) {
      circleSize = 128;
    }

    return circleSize;
  }
}
