import 'package:flutter_svg/svg.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';

class RulesAlert extends StatelessWidget {
  const RulesAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RULES',
              style: TextStyle(
                color: ColorsConstants.darkText,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              key: WidgetKeysConstants.closeRulesModal,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(ImagesConstants.icons.close),
            ),
          ],
        ),
        SizedBox(
          width: 400,
          // TODO(app): Renderizar imagem em svg com outra dependência
          child: Image.asset(ImagesConstants.rules2),
        ),
      ],
    );
  }
}
