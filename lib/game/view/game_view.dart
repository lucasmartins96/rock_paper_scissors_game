import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/images_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/widget_keys_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/models/models.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/game_pick_empty.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/rules_modal.dart';
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
          return _buildGamePicks(state.gameInitialPicks);
        } else if (state is UserPickState) {
          return _buildUserPick(state.playerGamePick);
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildGamePicks(List<GamePick> gamePicks) {
    final paperPick = gamePicks[0];
    final scissorPick = gamePicks[1];
    final rockPick = gamePicks[2];

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
              pickImagePath: paperPick.iconPath,
              gradientFirstColor: paperPick.gradientBorderFirstColor,
              gradientSecondColor: paperPick.gradientBorderSecondColor,
              action: () => _handleGamePick(paperPick),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GamePickButton(
              key: const Key('player_game_pick_scissor'),
              pickImagePath: scissorPick.iconPath,
              gradientFirstColor: scissorPick.gradientBorderFirstColor,
              gradientSecondColor: scissorPick.gradientBorderSecondColor,
              action: () => _handleGamePick(scissorPick),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GamePickButton(
              key: const Key('player_game_pick_rock'),
              pickImagePath: rockPick.iconPath,
              gradientFirstColor: rockPick.gradientBorderFirstColor,
              gradientSecondColor: rockPick.gradientBorderSecondColor,
              action: () => _handleGamePick(rockPick),
            ),
          ),
        ],
      ),
    );
  }

  void _handleGamePick(GamePick gamePick) {
    context.read<GameBloc>().add(GameUserPickedEvent(gamePick));
  }

  Widget _buildUserPick(GamePick? userPick) {
    return Row(
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
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'YOU PICKED',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: const [
              GameEmptyPick(key: WidgetKeysConstants.emptyPick),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'THE HOUSE PICKED',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRulesButton() {
    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (_) => const RulesModal(
            key: WidgetKeysConstants.rulesModal,
          ),
        );
      },
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
