import 'package:frontend_mentor_rock_paper_scissors/common.dart';

class GamePickButtonInvisiblePadding extends StatelessWidget {
  const GamePickButtonInvisiblePadding({
    super.key,
    required this.gamePickButton,
  });

  final Widget gamePickButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(84),
      child: gamePickButton,
    );
  }
}
