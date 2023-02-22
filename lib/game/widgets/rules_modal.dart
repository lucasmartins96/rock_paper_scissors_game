import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';

class RulesModal extends StatelessWidget {
  const RulesModal() : super(key: WidgetKeysConstants.rulesModal);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 64),
              child: Text(
                'RULES',
                style: TextStyle(
                  color: ColorsConstants.darkText,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              // TODO(app): Renderizar imagem em svg com outra dependência
              child: Image.asset(ImagesConstants.rules2),
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
      ),
    );
  }
}
