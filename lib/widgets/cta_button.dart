import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class CtaButton extends StatelessWidget {
  final bool isLoading;
  final Function onTap;
  CtaButton({this.onTap, this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: kBigBoxPadding, horizontal: kBigBoxPadding + 1),
          height: kCtaHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: colorCtaBackground,
            borderRadius: BorderRadius.all(Radius.circular(kCtaHeight / 2)),
            // boxShadow: [
            //   BoxShadow(
            //     color: colorCtaBackground.withOpacity(0.5),
            //     spreadRadius: 0,
            //     blurRadius: 35,
            //     offset: Offset(0, 8), // changes position of shadow
            //   ),
            // ],
          ),
          child: Center(
            child: isLoading
                ? Container(
                    height: kCtaHeight / 2,
                    width: kCtaHeight / 2,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                : Padding(
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
      ),
    );
  }
}
