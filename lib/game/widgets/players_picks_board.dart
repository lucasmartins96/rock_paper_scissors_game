import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

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
    final homePick = state.homePick;

    _handleStartAnimation(state.isUserWin);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: -50,
              child: Stack(
                children: [
                  _handleBuildUserGamePickButton(userPick),
                  Positioned(
                    left: 100,
                    bottom: 0,
                    child: _buildUserPickName('YOU PICKED'),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -50,
              child: Stack(
                children: [
                  _handleBuildHomeGamePickButton(homePick),
                  Positioned(
                    right: 75,
                    bottom: 0,
                    child: _buildUserPickName('THE HOUSE PICKED'),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                child: FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: [
                        Text(
                          _handleMessage(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            letterSpacing: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<GameBloc>().add(GameStartedEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 64,
                                vertical: 12,
                              ),
                              child: Text(
                                'PLAY AGAIN',
                                style: TextStyle(
                                  color: ColorsConstants.darkText,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleStartAnimation(bool? isUserWin) {
    if (isUserWin != null) {
      _controller.forward();
    }
  }

  Widget _handleBuildUserGamePickButton(GamePick? userPick) {
    final state = context.watch<GameBloc>().state;
    final isUserWin = state.isUserWin;

    if (isUserWin != null && isUserWin) {
      return _buildPickButtonDopplerBorder(userPick);
    }

    return GamePickButtonInvisiblePadding(
      gamePickButton: GamePickButton(
        key: userPick!.buttonKey,
        pickImagePath: userPick.iconPath,
        gradientFirstColor: userPick.gradientBorderFirstColor,
        gradientSecondColor: userPick.gradientBorderSecondColor,
      ),
    );
  }

  Padding _buildUserPickName(String pickName) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        pickName,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 1,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _handleBuildHomeGamePickButton(GamePick? homePick) {
    final state = context.watch<GameBloc>().state;
    final isUserWin = state.isUserWin;

    if (isUserWin != null && !isUserWin) {
      return _buildPickButtonDopplerBorder(homePick);
    }

    return HomePick(homePick: homePick);
  }

  String _handleMessage() {
    final state = context.watch<GameBloc>().state;

    if (state.isUserWin == null) {
      return '';
    }
    return state.isUserWin! ? 'YOU WIN' : 'YOU LOSE';
  }

  AnimatedBuilder _buildPickButtonDopplerBorder(GamePick? userPick) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GamePickButtonDopplerBorder(
          pickImagePath: userPick!.iconPath,
          gradientFirstColor: userPick.gradientBorderFirstColor,
          gradientSecondColor: userPick.gradientBorderSecondColor,
        );
      },
    );
  }
}
