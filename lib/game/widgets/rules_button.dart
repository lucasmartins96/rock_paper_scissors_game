import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';

class RulesButton extends StatelessWidget {
  const RulesButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Realizar testes nos dispositivos menores
    final isDesktop = LayoutProvider.of(context).isDesktop;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var horizontal = 24.0;
    var vertical = 12.0;
    var textScaleFactor = 1.0;

    // if ((width > 1600 && width <= 2000) && (height > 900 && height <= 2000)){
    //   horizontal = 48.0;
    //   vertical = 24.0;
    //   textScaleFactor = 1.2;
    // }
    if (width > 1600 && height > 900) {
      horizontal = 48.0;
      vertical = 24.0;
      textScaleFactor = 1.2;
    }

    return OutlinedButton(
      onPressed: () {
        if (isDesktop) {
          _showRulesAlert(context);
          return;
        }
        _showRulesModal(context);
      },
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        side: const BorderSide(width: 1.5, color: Colors.white),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Text(
          'RULES',
          textScaleFactor: textScaleFactor,
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showRulesAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const RulesAlert(),
    );
  }

  Future<void> _showRulesModal(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const RulesModal(),
    );
  }
}
