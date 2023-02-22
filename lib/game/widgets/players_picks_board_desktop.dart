import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class PlayersPicksBoardDesktop extends StatefulWidget {
  const PlayersPicksBoardDesktop({super.key});

  @override
  State<PlayersPicksBoardDesktop> createState() =>
      _PlayersPicksBoardDesktopState();
}

class _PlayersPicksBoardDesktopState extends State<PlayersPicksBoardDesktop> {
  double circleSize = 300;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameBloc>().state;
    final userPick = state.userPick;
    final homePick = state.homePick;

    _handleCircleSize(MediaQuery.of(context).size.width);

    return state.status == GameStatus.finish
        ? const PlayersPicksBoardDesktopResult()
        : Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 202,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildUserPickName('YOU PICKED'),
                                  _buildGamePickButton(userPick),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 100),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildUserPickName('THE HOUSE PICKED'),
                                  if (state.homePick == null)
                                    _buildEmptyPick()
                                  else
                                    _buildGamePickButton(homePick),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }

  void _handleCircleSize(double width) {
    if (width <= 1300 && circleSize == 300) {
      setState(() {
        circleSize = 250;
      });
    } else if (width <= 1200 && circleSize == 250) {
      setState(() {
        circleSize = 200;
      });
    } else if (width <= 1000 && circleSize == 200) {
      setState(() {
        circleSize = 150;
      });
    }
  }

  Widget _buildGamePickButton(GamePick? userPick) {
    return GamePickButton(
      key: userPick!.buttonKey,
      pickImagePath: userPick.iconPath,
      gradientFirstColor: userPick.gradientBorderFirstColor,
      gradientSecondColor: userPick.gradientBorderSecondColor,
      circleSize: circleSize,
    );
  }

  Widget _buildUserPickName(String pickName) {
    var textScaleFactor = 1.5;

    if (MediaQuery.of(context).size.width <= 900) {
      textScaleFactor = 1.2;
    }

    return Text(
      pickName,
      textScaleFactor: textScaleFactor,
      style: const TextStyle(
        color: Colors.white,
        letterSpacing: 3,
        fontWeight: FontWeight.w800,
        fontSize: 16, //16
      ),
    );
  }

  Widget _buildEmptyPick() => const GameEmptyPick();
}
