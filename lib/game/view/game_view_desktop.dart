import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GameViewDesktop extends StatefulWidget {
  const GameViewDesktop({super.key});

  @override
  State<GameViewDesktop> createState() => _GameViewDesktopState();
}

class _GameViewDesktopState extends State<GameViewDesktop> {
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Align(child: PageStepsWrapper()),
          Stack(
            children: const [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 52),
                  child: Header(),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 32, bottom: 32),
                  child: RulesButton(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
