import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class PlayersPicksBoardDesktopResult extends StatefulWidget {
  const PlayersPicksBoardDesktopResult({super.key});

  @override
  State<PlayersPicksBoardDesktopResult> createState() =>
      _PlayersPicksBoardDesktopResultState();
}

class _PlayersPicksBoardDesktopResultState
    extends State<PlayersPicksBoardDesktopResult>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  double circleSize = 300;

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
    _handleCircleSize();

    return Stack(
      children: [
        _buildPickLeftSide(userPick),
        _buildPickRightSide(homePick),
        _buildGameResult(),
      ],
    );
  }

  Widget _buildPickLeftSide(GamePick? userPick) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var textStart = 305.0;
    var bottomPositioned = -100.0;
    var topPositioned = 120.0;

    // if ((width > 1600 && width <= 2000) && (height > 900 && height <= 2000)){
    //   textStart = 380;
    // } else if (width > 1200 && width <= 1300) {
    //   textStart = 265.0;
    // } else if (width > 1000 && width <= 1200) {
    //   textStart = 245.0;
    // } else if (width > 900 && width <= 1000) {
    //   textStart = 220.0;
    // } else if (width > 768 && width <= 900) {
    //   textStart = 210.0;
    // }
    if (width > 1600 && height > 900) {
      textStart = 380;
    } else if (width > 1200) {
      textStart = 265.0;
    } else if (width > 1000) {
      textStart = 245.0;
    } else if (width > 900) {
      textStart = 220.0;
    } else {
      textStart = 210.0;
    }

    if (width > 800 && width <= 900) {
      bottomPositioned = -52.0;
      topPositioned = 140.0;
    }

    return PositionedDirectional(
      start: -30,
      bottom: bottomPositioned,
      child: Stack(
        children: [
          PositionedDirectional(
            top: topPositioned,
            start: textStart,
            child: _buildUserPickName('YOU PICKED'),
          ),
          _handleBuildUserGamePickButton(userPick),
        ],
      ),
    );
  }

  Widget _buildPickRightSide(GamePick? homePick) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var textStart = 270.0;
    var bottomPositioned = -100.0;

    // if ((width > 1600 && width <= 2000) && (height > 900 && height <= 2000)) {
    //   textStart = 320;
    // } else if (MediaQuery.of(context).size.width > 1200 &&
    //     MediaQuery.of(context).size.width <= 1300) {
    //   textStart = 230.0;
    // } else if (MediaQuery.of(context).size.width > 1000 &&
    //     MediaQuery.of(context).size.width <= 1200) {
    //   textStart = 210.0;
    // } else if (MediaQuery.of(context).size.width > 900 &&
    //     MediaQuery.of(context).size.width <= 1000) {
    //   textStart = 180.0;
    // } else if (MediaQuery.of(context).size.width > 768 &&
    //     MediaQuery.of(context).size.width <= 900) {
    //   textStart = 170.0;
    // }
    if (width > 1600 && height > 900) {
      textStart = 320;
    } else if (width > 1200) {
      textStart = 230.0;
    } else if (width > 1000) {
      textStart = 210.0;
    } else if (width > 900) {
      textStart = 180.0;
    } else {
      textStart = 170.0;
    }

    if (width <= 900) {
      bottomPositioned = -40.0;
    }

    return PositionedDirectional(
      end: 0,
      bottom: bottomPositioned,
      child: Stack(
        children: [
          PositionedDirectional(
            top: 120,
            start: textStart,
            child: _buildUserPickName('THE HOUSE PICKED'),
          ),
          _handleBuildHomeGamePickButton(homePick),
        ],
      ),
    );
  }

  Widget _buildGameResult() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final middleHeight = (height / 2) - 200;
    var middleWidthFactor = 115;
    var fontSize = 60.0;
    var paddingBottom = 32.0;
    var paddingTop = 16.0;

    // if ((width > 1800 && width <= 2000) && (height > 900 && height <= 2000)){
    //   fontSize = 80.0;
    //   middleWidthFactor = 170;
    // } else if (width > 1300 && width <= 1800) {
    //   fontSize = 50.0;
    // } else if (width > 1200 && width <= 1300) {
    //   fontSize = 50.0;
    // } else if (width > 1000 && width <= 1200) {
    //   fontSize = 40.0;
    //   paddingBottom = 0.0;
    //   paddingTop = 8.0;
    //   middleWidthFactor = 100;
    // } else if (width > 900 && width <= 1000) {
    //   fontSize = 30.0;
    //   paddingBottom = 0.0;
    //   paddingTop = 8.0;
    //   middleWidthFactor = 90;
    // } else if (width > 768 && width <= 900) {
    //   fontSize = 30.0;
    //   paddingBottom = 0.0;
    //   paddingTop = 8.0;
    //   middleWidthFactor = 80;
    // }
    if (width > 1800 && height > 900) {
      fontSize = 80.0;
      middleWidthFactor = 170;
    } else if (width > 1300) {
      fontSize = 50.0;
    } else if (width > 1200) {
      fontSize = 50.0;
    } else if (width > 1000) {
      fontSize = 40.0;
      paddingBottom = 0.0;
      paddingTop = 8.0;
      middleWidthFactor = 100;
    } else if (width > 900) {
      fontSize = 30.0;
      paddingBottom = 0.0;
      paddingTop = 8.0;
      middleWidthFactor = 90;
    } else {
      fontSize = 30.0;
      paddingBottom = 0.0;
      paddingTop = 8.0;
      middleWidthFactor = 80;
    }

    final middleWidth = (width / 2) - middleWidthFactor;

    return PositionedDirectional(
      bottom: middleHeight,
      start: middleWidth,
      child: SizedBox(
        child: FadeTransition(
          opacity: _animation,
          child: Padding(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: Column(
              children: [
                Text(
                  _handleMessage(),
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: paddingTop),
                  child: _buildPlayAgainButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayAgainButton() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var fontSize = 16.0;
    var paddingHorizontal = 44.0;
    var paddingVertical = 16.0;

    // if ((width > 1800 && width <= 2000) && (height > 900 && height <= 2000)){
    //   fontSize = 20;
    //   paddingHorizontal = 90;
    //   paddingVertical = 20;
    // } else if (width > 1800 && width <= 2000) {
    //   fontSize = 20;
    //   paddingHorizontal = 80;
    //   paddingVertical = 20;
    // } else if (width > 1000 && width <= 1200) {
    //   fontSize = 14.0;
    //   paddingHorizontal = 28.0;
    //   paddingVertical = 12.0;
    // } else if (width > 768 && width <= 1000) {
    //   fontSize = 12.0;
    //   paddingHorizontal = 20.0;
    //   paddingVertical = 10.0;
    // }
    if (width > 1800 && height > 900) {
      fontSize = 20;
      paddingHorizontal = 90;
      paddingVertical = 20;
    } else if (width > 1800) {
      fontSize = 20;
      paddingHorizontal = 80;
      paddingVertical = 20;
    } else if (width > 1000) {
      fontSize = 14.0;
      paddingHorizontal = 28.0;
      paddingVertical = 12.0;
    } else {
      fontSize = 12.0;
      paddingHorizontal = 20.0;
      paddingVertical = 10.0;
    }

    return ElevatedButton(
      onPressed: () {
        context.read<GameBloc>().add(GameStartedEvent());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        child: Text(
          'PLAY AGAIN',
          textScaleFactor: 1,
          style: TextStyle(
            color: ColorsConstants.darkText,
            fontSize: fontSize,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  void _handleStartAnimation(bool? isUserWin) {
    if (isUserWin != null) {
      _controller.forward();
    }
  }

  void _handleCircleSize() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // if ((width > 1800 && width <= 2000) && (height > 1000 && height <= 2000))
    // {
    //   setState(() {
    //     circleSize = 500;
    //   });
    // } else if ((width > 1440 && width <= 1800) &&
    //     (height > 900 && height <= 1000)) {
    //   setState(() {
    //     circleSize = 400;
    //   });
    // } else if (width > 1200 && width <= 1440) {
    //   setState(() {
    //     circleSize = 250;
    //   });
    // } else if (width > 1000 && width <= 1200) {
    //   setState(() {
    //     circleSize = 200;
    //   });
    // } else if (width > 800 && width <= 1000) {
    //   setState(() {
    //     circleSize = 150;
    //   });
    // }
    if (width > 1800 && height > 1000) {
      setState(() {
        circleSize = 500;
      });
      return;
    } else if (width > 1440 && height > 900) {
      setState(() {
        circleSize = 400;
      });
      return;
    } else if (width > 1200) {
      setState(() {
        circleSize = 250;
      });
      return;
    } else if (width > 1000) {
      setState(() {
        circleSize = 200;
      });
      return;
    } else if (width > 800) {
      setState(() {
        circleSize = 150;
      });
      return;
    }
  }

  Widget _handleBuildUserGamePickButton(GamePick? userPick) {
    final state = context.watch<GameBloc>().state;
    final isUserWin = state.isUserWin;

    if (isUserWin != null && isUserWin) {
      return _buildPickButtonDopplerBorder(userPick);
    }

    return GamePickButtonInvisiblePadding(
      gamePickButton: _buildGamePickButton(userPick),
    );
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var textScaleFactor = 1.5;

    if (width > 1600 && height > 900) {
      textScaleFactor = 2;
    } else {
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

  Widget _handleBuildHomeGamePickButton(GamePick? homePick) {
    final state = context.watch<GameBloc>().state;
    final isUserWin = state.isUserWin;

    if (isUserWin != null && !isUserWin) {
      return _buildPickButtonDopplerBorder(homePick);
    }

    return GamePickButtonInvisiblePadding(
      gamePickButton: _buildGamePickButton(homePick),
    );
  }

  String _handleMessage() {
    final state = context.watch<GameBloc>().state;

    if (state.isUserWin == null) {
      return '';
    }

    return state.isUserWin! ? 'YOU WIN' : 'YOU LOSE';
  }

  Widget _buildPickButtonDopplerBorder(GamePick? userPick) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GamePickButtonDopplerBorder(
          key: userPick!.buttonKey,
          pickImagePath: userPick.iconPath,
          gradientFirstColor: userPick.gradientBorderFirstColor,
          gradientSecondColor: userPick.gradientBorderSecondColor,
          circleSize: circleSize,
        );
      },
    );
  }
}
