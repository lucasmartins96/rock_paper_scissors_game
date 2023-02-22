import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class GamePickButtonBase extends StatelessWidget {
  const GamePickButtonBase({
    super.key,
    required this.containerBorderDecoration,
    this.containerPickImageDecoration,
    this.pickImage,
    this.circleSize,
  });

  final Decoration containerBorderDecoration;
  final Decoration? containerPickImageDecoration;
  final Widget? pickImage;
  final double? circleSize;

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutProvider.of(context).isDesktop;
    final firstContainerPadding = isDesktop ? (circleSize! / 7.8) : 16.0;
    final secondContainerPadding = isDesktop ? (circleSize! / 5.2) : 24.0;

    return Container(
      width: circleSize ?? 128,
      height: circleSize ?? 128,
      decoration: containerBorderDecoration,
      padding: EdgeInsets.all(firstContainerPadding),
      child: Container(
        padding: EdgeInsets.all(secondContainerPadding),
        decoration: containerPickImageDecoration,
        child: pickImage,
      ),
    );
  }
}
