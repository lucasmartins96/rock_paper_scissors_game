import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class GameScore extends StatelessWidget {
  const GameScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsConstants.headerOutline,
      ),
      child: BlocConsumer<ScoreCubit, int>(
        listener: (context, state) {},
        builder: (context, score) {
          return Column(
            children: [
              const Text('score'),
              Text('$score'),
            ],
          );
        },
      ),
    );
  }
}
