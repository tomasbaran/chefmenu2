import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/change_notifiers/tab_index.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';

class MyTabBar extends StatelessWidget {
  MyTabBar(this._tabController);
  final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: kBigBoxPadding,
        right: kBigBoxPadding,
        //bottom: kBottomBigBoxPadding - 2 * kBigBoxPadding,
        //same as big_box_container.dart margin; ternary operators: for the bottom scroll up animation
        bottom: (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding
            ? kBottomBigBoxPadding - 2 * kBigBoxPadding
            : Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context) + kBigBoxPadding
                ? kBigBoxPadding + (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) - 2 * kBigBoxPadding
                : 0,
      ),
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TabBar(
          // onTap: (index) {
          //   setState(() {
          //     print('index: ${widget._tabController.index}');
          //   });
          // },
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: colorShade2,
          indicatorColor: Colors.blue,
          indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
          tabs: [
            Tab(
                icon: Image.asset('icons/218-bacon-1.png',
                    height: kTabIconHeight, color: Provider.of<TabIndex>(context).position == 0 ? colorTabActive : colorTabInactive)),
            Tab(
                icon:
                    Image.asset('icons/164-crab.png', height: kTabIconHeight, color: _tabController.index == 1 ? colorTabActive : colorTabInactive)),
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
