import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePickButtonInvisiblePadding extends StatelessWidget {
  const GamePickButtonInvisiblePadding({
    super.key,
    required this.gamePickButton,
  });

  final Widget gamePickButton;

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutProvider.of(context).isDesktop;
    final width = MediaQuery.of(context).size.width;
    var desktopContainerPadding = 215.0;

    if (width > 800 && width <= 900) {
      desktopContainerPadding = 185;
    }
    // else if (MediaQuery.of(context).size.width > 768 &&
    //     MediaQuery.of(context).size.width <= 800) {
    //   desktopContainerPadding = 135;
    // }

    final padding = isDesktop ? desktopContainerPadding : 84.0;

    return Container(
      padding: EdgeInsets.all(padding),
      child: gamePickButton,
    );
  }
}
