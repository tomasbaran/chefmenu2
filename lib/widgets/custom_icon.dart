import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.name, {
    Key key,
    this.height,
    this.color,
  }) : super(key: key);

  final String name;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;

    if (iconOpacity != 1.0) iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    return SvgPicture.asset(
      name,
      color: iconColor,
      height: kTabIconHeight,
    );
  }
}
