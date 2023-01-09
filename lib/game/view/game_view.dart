import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: Inserir componente de score
        _handlePageSteps(),
        OutlinedButton(
          onPressed: () {},
          child: Text('RULES'),
        ),
      ],
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
    return Column(
      children: [
        GamePick(key: Key('player_game_pick_paper')),
        GamePick(key: Key('player_game_pick_rock')),
        GamePick(key: Key('player_game_pick_scissor')),
      ],
    );
  }
}
