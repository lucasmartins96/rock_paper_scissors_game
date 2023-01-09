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
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: BlocConsumer<ScoreCubit, int>(
        listener: (context, state) {},
        builder: (context, score) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SCORE',
                style: TextStyle(
                  color: ColorsConstants.scoreText,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '$score',
                style: const TextStyle(
                  color: ColorsConstants.darkText,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
