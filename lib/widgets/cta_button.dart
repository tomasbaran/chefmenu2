import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class CtaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(kBigBoxPadding),
        height: kCtaHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: colorCtaBackground, borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CREAR MENÚ', style: ktsCta),
                Text('GRATIS PARA SIEMPRE', style: kts2Cta),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
