import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';

class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: kBigBoxPadding, right: kBigBoxPadding, bottom: kBottomBigBoxPadding - 2 * kBigBoxPadding),
      padding: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorShade3,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: colorShade2,
          indicatorColor: Colors.white12,
          indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
          tabs: [
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ac_unit)),
          ],
        ),
      ),
    );
  }
}
