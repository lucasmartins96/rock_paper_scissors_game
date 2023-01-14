import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class AnimatedGameResult extends StatefulWidget {
  const AnimatedGameResult({super.key, this.isUserWin});

  final bool? isUserWin;

  @override
  State<AnimatedGameResult> createState() => _AnimatedGameResultState();
}

class _AnimatedGameResultState extends State<AnimatedGameResult>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _handleInitializeAnimations();
  }

  void _handleInitializeAnimations() {
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
      final isUserWin = widget.isUserWin;
      widget.isUserWin != null && isUserWin!
          ? context.read<ScoreCubit>().increment()
          : context.read<ScoreCubit>().decrement();
    }
  }

  void _handleStartAnimation() {
    if (widget.isUserWin != null) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _handleStartAnimation();
    return SizedBox(
      child: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
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
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
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
    );
  }

  String _handleMessage() {
    if (widget.isUserWin == null) {
      return '';
    }
    return widget.isUserWin! ? 'YOU WIN' : 'YOU LOSE';
  }
}
