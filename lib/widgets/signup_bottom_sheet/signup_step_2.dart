import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'swipable_horizontal_line.dart';

class SignupStep2 extends StatelessWidget {
  final String registeredEmail;
  SignupStep2({this.registeredEmail});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kCtaHeight / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: kSignupFieldPadding),
          SwipableHorizontalLine(),
          SizedBox(height: kSignupBottomSheetCornerRadius / 4),
          Icon(CupertinoIcons.check_mark_circled, size: 60, color: colorGreen),
          SizedBox(height: kSignupBottomSheetCornerRadius / 2),
          Text(
            '¡Enhorabuena!',
            textAlign: TextAlign.center,
            style:
                MediaQuery.of(context).platformBrightness == Brightness.dark ? ktsSignupFieldStep2DarkThemeTitle : ktsSignupFieldStep2LightThemeTitle,
          ),
          SizedBox(height: kSignupBottomSheetCornerRadius),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style:
                    MediaQuery.of(context).platformBrightness == Brightness.dark ? ktsSignupStep2DarkThemeMessage : ktsSignupStep2LightThemeMessage,
                children: [
                  TextSpan(text: 'Una vez que el Admin para crear el menú esté listo, le enviaremos las instrucciones a '),
                  TextSpan(text: registeredEmail, style: TextStyle(decoration: TextDecoration.underline)),
                ]),
          ),
          SizedBox(height: kSignupBottomSheetCornerRadius / 2),
          Text(
            'Trabajamos para que funcione genial.',
            textAlign: TextAlign.center,
            style: MediaQuery.of(context).platformBrightness == Brightness.dark ? ktsSignupStep2DarkThemeMessage : ktsSignupStep2LightThemeMessage,
          ),
          SizedBox(height: kSignupBottomSheetCornerRadius),
        ],
      ),
    );
  }
}
