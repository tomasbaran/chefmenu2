import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar(this._tabController);
  final TabController _tabController;

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: kBigBoxPadding, right: kBigBoxPadding, bottom: kBottomBigBoxPadding - 2 * kBigBoxPadding),
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TabBar(
          onTap: (index) {
            setState(() {
              print('index: ${widget._tabController.index}');
            });
          },
          controller: widget._tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: colorShade2,
          indicatorColor: Colors.blue,
          indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
          tabs: [
            Tab(
                icon: Image.asset('icons/218-bacon-1.png',
                    height: kTabIconHeight, color: widget._tabController.index == 0 ? colorTabActive : colorTabInactive)),
            Tab(
                icon: Image.asset('icons/164-crab.png',
                    height: kTabIconHeight, color: widget._tabController.index == 1 ? colorTabActive : colorTabInactive)),
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
