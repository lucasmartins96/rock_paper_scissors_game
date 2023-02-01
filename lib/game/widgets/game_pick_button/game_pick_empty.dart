import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_button/game_pick_button_base.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_button/game_pick_button_padding.dart';

class GameEmptyPick extends StatelessWidget {
  const GameEmptyPick() : super(key: WidgetKeysConstants.emptyPick);

  @override
  Widget build(BuildContext context) {
    return GamePickButtonInvisiblePadding(
      gamePickButton: GamePickButtonBase(
        containerBorderDecoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        containerPickImageDecoration: BoxDecoration(
          color: ColorsConstants.gradient.background.color.shade900,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
