import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;

        return Scaffold(
          body: SafeArea(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GameBloc()..add(GameStartedEvent()),
                ),
                BlocProvider(
                  create: (context) => ScoreCubit(),
                ),
              ],
              child: LayoutProvider(
                isDesktop: isDesktop,
                child: isDesktop
                    ? const GameViewDesktop()
                    : const GameViewMobile(),
              ),
            ),
          ),
        );
      },
    );
  }
}
