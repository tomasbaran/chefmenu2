import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class SwipableHorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: kSignupBottomSheetHorizontalLineWidth,
        height: kSignupBottomSheetHorizontalLineHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90)),
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? colorSignupBottomSheetHorizontalDarkLine
              : colorSignupBottomSheetHorizontalLightLine,
        ));
  }
}
