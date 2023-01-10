import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/images_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorsConstants.gradient.background.color.shade800,
            ColorsConstants.gradient.background.color.shade900,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(),
            _handlePageSteps(),
            _buildRulesButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 100,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsConstants.headerOutline,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(child: SvgPicture.asset(ImagesConstants.logo)),
            const GameScore(),
          ],
        ),
      ),
    );
  }

  Widget _handlePageSteps() {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameInitialState) {
          return _buildGamePicks();
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildGamePicks() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Align(
            child: SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset(ImagesConstants.bgTriangle),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GamePickButton(
              key: const Key('player_game_pick_paper'),
              pickImagePath: ImagesConstants.icons.paper,
              gradientFirstColor: ColorsConstants.gradient.paper.color.shade300,
              gradientSecondColor:
                  ColorsConstants.gradient.paper.color.shade400,
              action: () {},
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GamePickButton(
              key: const Key('player_game_pick_scissor'),
              pickImagePath: ImagesConstants.icons.scissor,
              gradientFirstColor:
                  ColorsConstants.gradient.scissors.color.shade400,
              gradientSecondColor:
                  ColorsConstants.gradient.scissors.color.shade500,
              action: () {},
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GamePickButton(
              key: const Key('player_game_pick_rock'),
              pickImagePath: ImagesConstants.icons.rock,
              gradientFirstColor: ColorsConstants.gradient.rock.color.shade400,
              gradientSecondColor: ColorsConstants.gradient.rock.color.shade500,
              action: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: const BorderSide(width: 1.5, color: Colors.white),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'RULES',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
