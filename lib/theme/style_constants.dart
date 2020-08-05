import 'package:flutter/material.dart';

// Colors
const Color colorShade1 = Color(0xFFEFF0F2);
const Color colorShade2 = Color(0xFF777777);
const Color colorShade3 = Color(0xFF424242);
const Color colorShade4 = Color(0xFF4B4935);
const Color colorShade5 = Color(0xFF3D2916);
const Color colorShade6 = Color(0xFF1D1C0A);

const Color colorBackground = Color(0xFF101A24);
const Color colorPrimary1 = Color(0xFFCC9757);
const Color colorRed = Color(0xFFEB5757);

// TabBar
const double kTabIconHeight = 28;

// Cover
const double kCoverHeightProportion = 0.35;
const TextStyle ktsRestaurantTitle = TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600, shadows: <Shadow>[
  Shadow(
    offset: Offset(1, 0),
    blurRadius: 13.0,
    color: Color.fromARGB(255, 0, 0, 0),
  )
]);

// BigBoxContainer
const double kBigBoxPadding = 8;
const double kBottomBigBoxPadding = 68;
const double kMaxCrossAxisExtent = 350;

// SliverAppBarLayer
const double kSliverAppBarLayerHeight = 100;
const TextStyle ktsCategoryTitle = TextStyle(color: colorPrimary1, fontSize: 32, fontWeight: FontWeight.w800);

// CTA
const double kCtaHeight = 52;
const double kCtaWidth = 358;
const Color colorCtaBackground = Colors.white;
const TextStyle ktsCta = TextStyle(color: colorRed, fontSize: 19, fontWeight: FontWeight.w700);