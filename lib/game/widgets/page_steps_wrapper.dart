import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class PageStepsWrapper extends StatelessWidget {
  const PageStepsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state.status == GameStatus.progress && state.homePick == null) {
          Future.delayed(
            const Duration(seconds: 2),
            () => context.read<GameBloc>().add(GameHomePickedEvent()),
          );
        } else if (state.status == GameStatus.progress &&
            state.homePick != null) {
          Future.delayed(
            const Duration(seconds: 2),
            () => context.read<GameBloc>().add(GameFinishedEvent()),
          );
        }
      },
      builder: (context, state) {
        if (state.status == GameStatus.start) {
          return GamePicksBoard(gamePicks: state.gamePicks);
        }
        return const PlayersPicksBoard();
      },
    );
  }
}
