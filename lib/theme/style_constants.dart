import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
const Color colorGreen = Color(0xFF74BF00);

const Color colorIosSafariLight = Color(0xFFF6F7F8);
const Color colorIosSafariDark = Color(0xFF575757);

// TabBar
const double kTabIconHeight = 28;
Color colorTabInactive = Colors.white.withOpacity(0.5);
const Color colorTabActive = colorBackground;
TextStyle ktsTabBar = GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.w800);

// Cover
const double kSmallScreenCoverColorOpacityCoefficient = 0.065;
const double kBigScreenCoverColorOpacityCoefficient = 0.020;
const double kCoverOpacitySecondStop = 0.7;
const double kExponent = 5;
const double kBlurSpeed = 0.027;
const double kRestaurantTitleMaxShadowBlur = 30;
const double kCoverHeightProportion = 0.35;
TextStyle ktsRestaurantTitle = GoogleFonts.niconne(
  //height: 2.3,
  color: Colors.white,
  fontSize: 42,
  shadows: <Shadow>[
    Shadow(offset: Offset(0, 1), blurRadius: kRestaurantTitleMaxShadowBlur / 2, color: Color.fromARGB(255, 0, 0, 0)),
    Shadow(offset: Offset(0, 1), blurRadius: kRestaurantTitleMaxShadowBlur, color: Color.fromARGB(255, 0, 0, 0)),
  ],
);

// BigBoxContainer
const double kBigBoxPadding = 8;
const double kBottomBigBoxPadding = 68 + kBigBoxPadding;
const double kMaxCrossAxisExtent = 250;

// SliverAppBarLayer aka SliverPersistentHeader
const double kSliverAppBarLayerHeight = 60;
TextStyle ktsCategoryTitle = GoogleFonts.nunitoSans(color: colorPrimary1, fontSize: 24, fontWeight: FontWeight.w800);

// CTA
const double kCtaShowtimeDelay = 15;
const double kCtaHeight = 60;
const double kCtaWidth = 358;
const Color colorCtaBackground = colorRed;
TextStyle ktsCta = GoogleFonts.nunitoSans(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800);
TextStyle kts2Cta = GoogleFonts.nunitoSans(color: Color(0xFFECB4B4), fontSize: 12, fontWeight: FontWeight.w500);

// MealCard
const double kMealCoverSize = 120;
const double kMealCardMargin = 8;
const double kMealBoxPadding = 12;
const double kMealBoxCornerRadius = 30;
const double kMealCoverCornerRadius = 20;
Color colorMealBox = Color(0x00707070).withOpacity(0.3);
TextStyle ktsMealBoxTitle = GoogleFonts.nunitoSans(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800, height: 1.1);
TextStyle ktsMealBoxDetail = GoogleFonts.nunitoSans(color: Color(0xFFE2E2E2), fontSize: 13, fontWeight: FontWeight.w300);
TextStyle ktsMealBoxPortion = GoogleFonts.nunitoSans(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600);
TextStyle ktsMealBoxPrice = GoogleFonts.nunitoSans(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800);

// SignupBottomSheet
const double kSignupBottomSheetCornerRadius = 42; //42px is iPhone XR's radius
const double kSignupBottomSheetHorizontalLineHeight = 4;
const double kSignupBottomSheetHorizontalLineWidth = 100;
const Color colorSignupBottomSheetHorizontalLightLine = Color(0xFFD4D4D4);
const Color colorSignupBottomSheetHorizontalDarkLine = Color(0xFF393939);
// SignupField
const double kSignupFieldPadding = 8;
const double kSignupFieldCornerRadius = 14;
TextStyle ktsSignupField = GoogleFonts.nunitoSans(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600);
TextStyle ktsHintSignupField = GoogleFonts.nunitoSans(color: Colors.white.withOpacity(0.5), fontSize: 18, fontWeight: FontWeight.w300);
// SignBottomSheet Step 2
TextStyle ktsSignupFieldStep2DarkThemeTitle = GoogleFonts.nunitoSans(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w800);
TextStyle ktsSignupStep2DarkThemeMessage = GoogleFonts.nunitoSans(color: Colors.white.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w400);
TextStyle ktsSignupFieldStep2LightThemeTitle = GoogleFonts.nunitoSans(color: colorBackground, fontSize: 31, fontWeight: FontWeight.w800);
TextStyle ktsSignupStep2LightThemeMessage =
    GoogleFonts.nunitoSans(color: colorBackground.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w400);
// Flushbar
const double kFlushbarPadding = 8;
