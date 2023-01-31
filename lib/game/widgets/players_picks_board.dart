import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class PlayersPicksBoard extends StatefulWidget {
  const PlayersPicksBoard({super.key});

  @override
  State<PlayersPicksBoard> createState() => _PlayersPicksBoardState();
}

class _PlayersPicksBoardState extends State<PlayersPicksBoard>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    )..addStatusListener(_handleStatusListener);
  }

  void _handleStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      final isUserWin = context.read<GameBloc>().state.isUserWin;

      isUserWin != null && isUserWin
          ? context.read<ScoreCubit>().increment()
          : context.read<ScoreCubit>().decrement();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
