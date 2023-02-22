// ignore_for_file: one_member_abstracts

import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

abstract class GameRepository {
  List<GamePick> getAllPicks();
}
