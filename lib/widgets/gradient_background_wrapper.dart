import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/style_constants.dart';

class GradientBackgroundWrapper extends StatelessWidget {
  GradientBackgroundWrapper({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [colorShade5, colorShade6, colorShade6], stops: [0.0, 0.4, 1.0]),
      ),
      child: child,
    );
  }
}
