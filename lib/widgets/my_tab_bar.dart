import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/change_notifiers/tab_index.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:universal_io/io.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';
import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';

class MyTabBar extends StatelessWidget {
  double tabBarBottomPadding(BuildContext context) {
    //MOBILE platform:
    if (Platform.isIOS || Platform.isAndroid)
      return kBigBoxPadding;
    //DESKTOP platform: same as big_box_container.dart margin; ternary operators: for the bottom scroll up animation
    else {
      if ((Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding)
        return kBottomBigBoxPadding - kBigBoxPadding;
      else if (Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context) + 2 * kBigBoxPadding)
        return kBottomBigBoxPadding - kBigBoxPadding;
      else if ((Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding)
        return kBigBoxPadding + (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) - 2 * kBigBoxPadding;
      else
        return kBigBoxPadding;
    }
  }

  MyTabBar(this._tabController);
  final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: kBigBoxPadding,
        right: kBigBoxPadding,
        // DEPRECATED: smooth movement of tabbar that was supposed to be moved together with the bottom padding of Big Box
        //bottom: kBottomBigBoxPadding - 2 * kBigBoxPadding,
        //same as big_box_container.dart margin; ternary operators: for the bottom scroll up animation
        // bottom: (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding
        //     ? kBottomBigBoxPadding - kBigBoxPadding
        //     : Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context) + 2 * kBigBoxPadding
        //         ? kBigBoxPadding + (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) - 2 * kBigBoxPadding
        //         : kBigBoxPadding,
        //bottom: kBigBoxPadding,
        bottom: tabBarBottomPadding(context),
      ),
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorBackground,
        //color: Colors.black38,
        //color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: colorShade2,
          indicatorColor: Colors.blue,
          indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
          tabs: [
            Tab(
              text: Platform.operatingSystem,
              // icon: Image.asset('icons/218-bacon-1.png',
              //     height: kTabIconHeight,
              //     color: Provider.of<TabIndex>(context).position == 0 ? colorTabActive : Colors.white.withOpacity(0.33) /* colorTabInactive */),
            ),
            Tab(
              text: Platform.operatingSystemVersion,
              // icon: Image.asset('icons/164-crab.png',
              //     height: kTabIconHeight, color: _tabController.index == 1 ? colorTabActive : Colors.white.withOpacity(0.33) /* colorTabInactive */),
            ),
            // Tab(
            //     icon:
            //         Image.asset('icons/205-bread.png', height: kTabIconHeight, color: _tabController.index == 2 ? colorTabActive : colorTabInactive)),
            // Tab(
            //     icon:
            //         Image.asset('icons/201-taco.png', height: kTabIconHeight, color: _tabController.index == 3 ? colorTabActive : colorTabInactive)),
            // Tab(
            //     icon:
            //         Image.asset('icons/200-cake.png', height: kTabIconHeight, color: _tabController.index == 4 ? colorTabActive : colorTabInactive)),
          ],
        ),
      ),
    );
  }
}
