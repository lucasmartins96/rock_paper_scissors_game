import 'package:frontend_mentor_rock_paper_scissors/common.dart';

class GamePickButtonBase extends StatelessWidget {
  const GamePickButtonBase({
    super.key,
    required this.containerBorderDecoration,
    this.containerPickImageDecoration,
    this.pickImage,
  });

  final Decoration containerBorderDecoration;
  final Decoration? containerPickImageDecoration;
  final Widget? pickImage;
  static const double circleSize = 128;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: containerBorderDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          // TODO: Definir um tamanho aqui
          padding: const EdgeInsets.all(24),
          decoration: containerPickImageDecoration,
          child: pickImage,
        ),
      ),
    );
  }
}
