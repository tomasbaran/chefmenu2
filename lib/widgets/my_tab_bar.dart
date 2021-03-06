import 'dart:io';
import 'package:chefmenu2/models/meal_category.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:universal_io/io.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';
import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/models/data.dart';

class MyTabBar extends StatelessWidget {
  //WORKAROUND: https://github.com/flutter/flutter/issues/64266
  //REASON for workaround: so tabBar does NOT cover the CTA at all times
  double tabBarBottomPadding(BuildContext context) {
    //MOBILE platform:
    if (Platform.isIOS || Platform.isAndroid)
      return kBigBoxPadding;
    //DESKTOP platform: same as big_box_container.dart margin; ternary operators: for the bottom scroll up animation
    else {
      if ((Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding)
        // prevent bottom padding to get bigger than kBottomBigBoxPadding
        return kBottomBigBoxPadding;
      else if (Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context) + 2 * kBigBoxPadding)
        // formula to slide btw kBottomBigBoxPadding && kBigBoxPadding; it is being moved together with the bottom padding of Big Box (so it's almost Big Box bottom padding copy)
        return kBigBoxPadding + (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) - 2 * kBigBoxPadding;
      else
        // prevent bottom padding to get smaller than kBigBoxPadding
        return kBigBoxPadding;
    }
  }

  MyTabBar({this.tabController, this.makeFabInvisible});
  final TabController tabController;
  final bool makeFabInvisible;

  List<Widget> tabBuilder() {
    List<Widget> output = [];

    for (MealCategory category in menu.categories) {
      output.add(Tab(text: category.title.toUpperCase()));
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: makeFabInvisible ? 0 : null,
      margin: EdgeInsets.only(
        left: kBigBoxPadding,
        right: kBigBoxPadding,
        bottom: tabBarBottomPadding(context),
      ),
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TabBar(
          labelStyle: ktsTabBar,
          controller: tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: colorShade2,
          indicatorColor: Colors.blue,
          indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
          tabs: tabBuilder(),
        ),
      ),
    );
  }
}
