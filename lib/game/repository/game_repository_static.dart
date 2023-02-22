import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GameRepositoryStatic implements GameRepository {
  @override
  List<GamePick> getAllPicks() {
    return [
      GamePick(
        pick: PlayerGamePicks.paper,
        iconPath: ImagesConstants.icons.paper,
        gradientBorderFirstColor: ColorsConstants.gradient.paper.color.shade300,
        gradientBorderSecondColor:
            ColorsConstants.gradient.paper.color.shade400,
        buttonKey: WidgetKeysConstants.gamePickPaperButton,
      ),
      GamePick(
        pick: PlayerGamePicks.scissor,
        iconPath: ImagesConstants.icons.scissor,
        gradientBorderFirstColor:
            ColorsConstants.gradient.scissors.color.shade400,
        gradientBorderSecondColor:
            ColorsConstants.gradient.scissors.color.shade500,
        buttonKey: WidgetKeysConstants.gamePickScissorButton,
      ),
      GamePick(
        pick: PlayerGamePicks.rock,
        iconPath: ImagesConstants.icons.rock,
        gradientBorderFirstColor: ColorsConstants.gradient.rock.color.shade400,
        gradientBorderSecondColor: ColorsConstants.gradient.rock.color.shade500,
        buttonKey: WidgetKeysConstants.gamePickRockButton,
      ),
    ];
  }
}
