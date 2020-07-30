import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/widgets/custom_icon.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
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
          indicatorColor: Colors.white,
          indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
          tabs: [
            Tab(icon: CustomIcon('icons/001-sausage-2.svg')),
            Tab(icon: CustomIcon('icons/028-steak.svg')),
            Tab(icon: CustomIcon('icons/061-pizza-2.svg')),
            Tab(icon: CustomIcon('icons/117-hot-dog.svg')),
            Tab(icon: CustomIcon('icons/185-cocktail.svg')),
            Tab(icon: CustomIcon('icons/001-sausage-2.svg')),
            Tab(icon: CustomIcon('icons/028-steak.svg')),
            Tab(icon: CustomIcon('icons/061-pizza-2.svg')),
            Tab(icon: CustomIcon('icons/117-hot-dog.svg')),
            Tab(icon: CustomIcon('icons/185-cocktail.svg')),
            Tab(icon: CustomIcon('icons/001-sausage-2.svg')),
            Tab(icon: CustomIcon('icons/028-steak.svg')),
            Tab(icon: CustomIcon('icons/061-pizza-2.svg')),
            Tab(icon: CustomIcon('icons/117-hot-dog.svg')),
            Tab(icon: CustomIcon('icons/185-cocktail.svg')),
            Tab(icon: CustomIcon('icons/001-sausage-2.svg')),
            Tab(icon: CustomIcon('icons/028-steak.svg')),
            Tab(icon: CustomIcon('icons/061-pizza-2.svg')),
            Tab(icon: CustomIcon('icons/117-hot-dog.svg')),
            Tab(icon: CustomIcon('icons/185-cocktail.svg')),
            Tab(icon: CustomIcon('icons/001-sausage-2.svg')),
            Tab(icon: CustomIcon('icons/028-steak.svg')),
            Tab(icon: CustomIcon('icons/061-pizza-2.svg')),
            Tab(icon: CustomIcon('icons/117-hot-dog.svg')),
            Tab(icon: CustomIcon('icons/185-cocktail.svg')),
          ],
        ),
      ),
    );
  }
}
