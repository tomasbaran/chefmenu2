import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class SignupBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: kkSignupBottomSheetColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kSignupBottomSheetCornerRadius),
            topRight: Radius.circular(kSignupBottomSheetCornerRadius),
          )),
      child: Column(
        children: [
          Text('Sign up to create menu'),
          TextField(
            autofocus: true,
          ),
          CtaButton(),
        ],
      ),
    );
  }
}
