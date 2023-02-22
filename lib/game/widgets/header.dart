import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_mentor_rock_paper_scissors/common.dart';
import 'package:frontend_mentor_rock_paper_scissors/config/config.dart';
import 'package:frontend_mentor_rock_paper_scissors/game/game.dart';
import 'package:frontend_mentor_rock_paper_scissors/score/score.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutProvider.of(context).isDesktop;
    final widthViewport = MediaQuery.of(context).size.width;
    final heightViewport = MediaQuery.of(context).size.height;
    var width = 700.0;
    var height = 150.0;

    // if ((widthViewport > 1600 && widthViewport <= 2000) &&
    //     (heightViewport > 900 && heightViewport <= 2000)) {
    //   width = 1080;
    //   height = 200;
    // }

    // TODO: Testar nos dispositivos
    if (widthViewport > 1600 && heightViewport > 900) {
      width = 1080;
      height = 200;
    }

    final widthHeader = isDesktop ? width : null;
    final heightHeader = isDesktop ? height : 100.0;
    final padding = isDesktop ? 20.0 : 12.0;

    return SizedBox(
      width: widthHeader,
      height: heightHeader,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsConstants.headerOutline,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(
            16, // TODO: Realizar testes nos dispositivos menores
          ),
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
}
