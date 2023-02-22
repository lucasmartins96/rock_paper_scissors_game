import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/colors_constants.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/widgets/widgets.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class GameScore extends StatelessWidget {
  const GameScore({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutProvider.of(context).isDesktop;

    return isDesktop ? _buildHeaderDesktop() : _buildHeaderMobile();
  }

  Widget _buildHeaderMobile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<ScoreCubit, int>(
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

  Widget _buildHeaderDesktop() {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<ScoreCubit, int>(
        builder: (context, score) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                textScaleFactor: 1.5,
                'SCORE',
                style: TextStyle(
                  color: ColorsConstants.scoreText,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '$score',
                textScaleFactor: 1,
                style: const TextStyle(
                  color: ColorsConstants.darkText,
                  fontSize: 50,
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
