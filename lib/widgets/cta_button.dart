import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

//TODO: make it a stateless widget
class CtaButton extends StatefulWidget {
  @override
  _CtaButtonState createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  String test = 'CREAR MENU';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          setState(() {
            test == 'CREAR MENU' ? test = 'tapped' : test = 'CREAR MENU';
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: kBigBoxPadding, horizontal: kBigBoxPadding + 1),
          height: kCtaHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: colorCtaBackground, borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(test, style: ktsCta),
                  Text('GRATIS PARA SIEMPRE', style: kts2Cta),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
