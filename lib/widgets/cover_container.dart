import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'dart:ui';
import 'package:chefmenu2/models/cover_aka_back_layer_formulas.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/models/my_scroll_position.dart';

class CoverContainer extends StatelessWidget {
  final String imageSrc;
  final String restaurantTitle;
  CoverContainer({this.imageSrc, this.restaurantTitle});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: coverHeight(context),
        decoration: BoxDecoration(
          //color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imageSrc),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: completeBlur(context), sigmaY: completeBlur(context)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      increaseColorLightness(colorPrimary1).withOpacity(opacity(context)),
                      increaseColorLightness(colorPrimary1).withOpacity(opacity(context)),
                      increaseColorLightness(colorPrimary1).withOpacity(0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0,
                      // UNUSED#1: Maybe better keep it simlpe than overdo it, that's why I commented it
                      // Provider.of<MyScrollPosition>(context).data < (MediaQuery.of(context).size.height)
                      //     ? kCoverOpacitySecondStop : calcLastOpacityPhase(context) < 1 ? calcLastOpacityPhase(context) : 1,
                      kCoverOpacitySecondStop,
                      1
                    ])),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: restaurantTitleTopPadding(context), left: kBigBoxPadding),
        child: Text(
          '    ' + restaurantTitle + '    ',
          style: ktsRestaurantTitle,
        ),
      ),
    ]);
  }
}
