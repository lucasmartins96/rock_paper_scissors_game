import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GameViewMobile extends StatefulWidget {
  const GameViewMobile({super.key});

  @override
  State<GameViewMobile> createState() => _GameViewMobileState();
}

class _GameViewMobileState extends State<GameViewMobile> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorsConstants.gradient.background.color.shade800,
            ColorsConstants.gradient.background.color.shade900,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Header(),
            PageStepsWrapper(),
            RulesButton(),
          ],
        ),
      ),
    );
  }
}
