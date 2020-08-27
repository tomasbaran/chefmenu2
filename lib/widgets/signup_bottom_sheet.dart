import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:universal_io/io.dart';

class SignupBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutSine,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark ? colorIosSafariDark : colorIosSafariLight,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kSignupBottomSheetCornerRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kSignupFieldPadding),
            Container(
                width: kSignupBottomSheetHorizontalLineWidth,
                height: kSignupBottomSheetHorizontalLineHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                  color: MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? colorSignupBottomSheetHorizontalDarkLine
                      : colorSignupBottomSheetHorizontalLightLine,
                )),
            SizedBox(height: kSignupBottomSheetCornerRadius / 2),
            SignupField(
              hint: 'email',
              keyboardType: TextInputType.emailAddress,
              onComplete: () {
                FocusScope.of(context).nextFocus();
              },
            ),
            SignupField(
              hint: 'contraseña',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onComplete: () {
                print('tada');
              },
            ),
            SizedBox(height: kSignupBottomSheetCornerRadius / 2 - kBigBoxPadding),
            CtaButton(),
            SizedBox(height: kSignupBottomSheetCornerRadius / 2),
          ],
        ),
      ),
    );
  }
}

class SignupField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function onComplete;
  SignupField({this.hint, this.keyboardType, this.obscureText = false, this.onComplete});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Platform.isIOS || Platform.isAndroid) ? null : 500,
      padding: const EdgeInsets.symmetric(vertical: kSignupFieldPadding, horizontal: kCtaHeight / 2),
      child: TextField(
        onEditingComplete: onComplete,
        keyboardAppearance: Brightness.dark,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: ktsSignupField,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: ktsHintSignupField,
          fillColor: colorBackground,
          focusColor: Colors.purple,
          filled: true,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(kSignupFieldCornerRadius)),
            //borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(kSignupFieldCornerRadius)),
          ),
        ),
      ),
    );
  }
}
