import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'signup_step_1.dart';
import 'signup_step_2.dart';

class SignupBottomSheet extends StatefulWidget {
  @override
  _SignupBottomSheetState createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  bool step1Done = false;
  String email;

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
        child: step1Done
            ? SignupStep2(registeredEmail: email)
            : SignupStep1(step1DoneCallback: (String registeredEmail) {
                setState(() {
                  email = registeredEmail;
                  step1Done = true;
                });
              }),
      ),
    );
  }
}
