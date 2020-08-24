import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import '../change_notifiers/my_scroll_position.dart';
import 'package:provider/provider.dart';
import 'dart:math';

// ----------------------------- ↓ Helper cover (back layer) calculation functions ↓ -----------------------------------

// anchor(context) is used in (big_box_container.dart) && below in (bottomTopPointsdiff(BuildContext context))
double topBigBoxPadding(dynamic context) =>
    (kCoverHeightProportion * MediaQuery.of(context).size.height) /
    (MediaQuery.of(context).size.height - (/* kBottomBigBoxPadding  */ kBigBoxPadding + kBigBoxPadding));

// scroll: ~160
double backLayerAnimationBottomPoint(BuildContext context) =>
    MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding - bottomTopPointsdiff(context);

// scroll: ~240
double backLayerAnimationTopPoint(BuildContext context) => MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding;

// delta btw Top and Bottom points
double bottomTopPointsdiff(BuildContext context) => topBigBoxPadding(context) / 3.5 * MediaQuery.of(context).size.height;

// default cover height before we start scrolling
double defaultCoverHeight(BuildContext context) => (MediaQuery.of(context).size.height) * kCoverHeightProportion + kBigBoxPadding;

// once we reach the bottom point, the cover starts growing according to this formula
double growingCoverHeight(BuildContext context) =>
    defaultCoverHeight(context) + Provider.of<MyScrollPosition>(context).data - backLayerAnimationBottomPoint(context);

double coverHeight(BuildContext context) => Provider.of<MyScrollPosition>(context).data < backLayerAnimationBottomPoint(context)
    ? defaultCoverHeight(context)
    : Provider.of<MyScrollPosition>(context).data < MediaQuery.of(context).size.height
        ? growingCoverHeight(context) // this is the formula
        : MediaQuery.of(context).size.height;

double completeBlur(BuildContext context) => Provider.of<MyScrollPosition>(context).data < backLayerAnimationTopPoint(context)
    ? blur(context, firstPhaseBlur(context))
    : blur(context, finalPhaseMaxBlur(context));

double blur(BuildContext context, double getFunction) =>
    // handles exception: blur boundary < 0
    Provider.of<MyScrollPosition>(context).data < backLayerAnimationBottomPoint(context) ? 0 : getFunction;

double firstPhaseBlur(BuildContext context) =>
    pow((Provider.of<MyScrollPosition>(context).data - backLayerAnimationBottomPoint(context)) * kBlurSpeed, kExponent);

double finalPhaseMaxBlur(BuildContext context) => pow(bottomTopPointsdiff(context) * kBlurSpeed, kExponent);

double opacity(BuildContext context) =>
    // handles exceptions: opacity boundary < 0 && opacity bouandary > 1
    completeOpacity(context) < 0 ? 0 : completeOpacity(context) > 1 ? 1 : completeOpacity(context);

double completeOpacity(BuildContext context) => Provider.of<MyScrollPosition>(context).data < backLayerAnimationTopPoint(context)
    ? (MediaQuery.of(context).size.height < 600 ? kSmallScreenCoverColorOpacityCoefficient : kBigScreenCoverColorOpacityCoefficient) *
        blur(context, firstPhaseBlur(context))
    : (MediaQuery.of(context).size.height < 600 ? kSmallScreenCoverColorOpacityCoefficient : kBigScreenCoverColorOpacityCoefficient) *
        blur(context, finalPhaseMaxBlur(context));

// DEPRECATED#1: Maybe better keep it simlpe than overdo it, that's why I commented it
// double calcLastOpacityPhase(BuildContext context) =>
//     (Provider.of<MyScrollPosition>(context).data - MediaQuery.of(context).size.height) * 0.001 + kCoverOpacitySecondStop;

Color increaseColorLightness(Color color) => HSVColor.fromColor(color).withValue(0.9).toColor();

double restaurantTitleTopPadding(BuildContext context) =>
    kCoverHeightProportion * MediaQuery.of(context).size.height - kRestaurantTitleMaxShadowBlur * 2;

// double kCoverOpacitySecondStop(BuildContext context) => Provider.of<MyScrollPosition>(context).data > MediaQuery.of(context).size.height ? 1 : kCoverOpacitySecondStop;

double coverOpacitySecondStop(BuildContext context) {
  if ((Provider.of<MyScrollPosition>(context).data - MediaQuery.of(context).size.height) > (1 - kCoverOpacitySecondStop) * 100)
    // upper boundary
    return 1;
  else if (Provider.of<MyScrollPosition>(context).data < MediaQuery.of(context).size.height)
    // lower boundary
    return kCoverOpacitySecondStop;
  else
    // formula for btw boundaries
    return kCoverOpacitySecondStop + (Provider.of<MyScrollPosition>(context).data - MediaQuery.of(context).size.height) * 0.01;
}

// ----------------------------- ↑ Helper cover (back layer) calculation functions ↑-----------------------------------
