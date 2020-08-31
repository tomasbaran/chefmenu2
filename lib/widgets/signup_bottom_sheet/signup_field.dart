import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:universal_io/io.dart';

class SignupField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function onComplete;
  final Function onChanged;
  SignupField({this.hint, this.keyboardType, this.obscureText = false, this.onComplete, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Platform.isIOS || Platform.isAndroid) ? null : 500,
      padding: const EdgeInsets.symmetric(vertical: kSignupFieldPadding, horizontal: kCtaHeight / 2),
      child: TextField(
        onChanged: onChanged,
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
