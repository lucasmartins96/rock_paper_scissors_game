import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class PlayersPicksBoard extends StatefulWidget {
  const PlayersPicksBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameBloc>().state;
    final userPick = state.userPick;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  GamePickButton(
                    key: userPick!.buttonKey,
                    pickImagePath: userPick.iconPath,
                    gradientFirstColor: userPick.gradientBorderFirstColor,
                    gradientSecondColor: userPick.gradientBorderSecondColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'YOU PICKED',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // TODO: Avaliar necessidade do BlocSelector
            BlocSelector<GameBloc, GameState, GamePick?>(
              selector: (state) => state.homePick,
              builder: (context, homePick) {
                return Expanded(
                  child: Column(
                    children: [
                      HomePick(homePick: homePick),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'THE HOUSE PICKED',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        AnimatedGameResult(isUserWin: state.isUserWin),
      ],
    );
  }
}
