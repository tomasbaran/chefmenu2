import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/animation/my_fade_in.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';
import 'package:flutter/rendering.dart';
import 'meal_card.dart';
import 'package:chefmenu2/models/data.dart';
import 'dart:core';

class BigBoxContainer extends StatefulWidget {
  BigBoxContainer({this.categoryTitle, this.tabController, this.scrollController});
  final TabController tabController;
  final String categoryTitle;
  final ScrollController scrollController;

  @override
  _BigBoxContainerState createState() => _BigBoxContainerState();
}

class _BigBoxContainerState extends State<BigBoxContainer> {
  int numberOfColumns(dynamic context) => ((MediaQuery.of(context).size.width - (2 * kBigBoxPadding)) / kMaxCrossAxisExtent).floor();

  List<MealCard> _buildGridTileList({dynamic context, int mealIndex, int categoryIndex}) => List.generate(
      mealIndex,
      (i) => MealCard(
            i: i,
            numberOfColumns: numberOfColumns(context),
            title: menu.categories[categoryIndex].meals[i].title,
            portion: menu.categories[categoryIndex].meals[i].portion,
            price: i.toDouble(),
            imageUrl: menu.categories[categoryIndex].meals[i].imageUrl,
            //currency: meals[0].currency,
            ingredients: menu.categories[categoryIndex].meals[i].ingredients,
          ));

  double bigBoxContainerBottomPadding(BuildContext context) {
    if ((Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding)
      // prevent bottom padding to get bigger than kBottomBigBoxPadding
      return kBottomBigBoxPadding;
    else if (Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context))
      // formula to slide btw kBottomBigBoxPadding && kBigBoxPadding; it is being moved together with the bottom padding of tabBar (so it's almost tabBar bottom padding copy)
      return kBigBoxPadding + (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context));
    else
      // prevent bottom padding to get smaller than kBigBoxPadding
      return kBigBoxPadding;
  }

  int _currentIndex = 0;
  int _previousIndex = 0;
  int valueA = 0;
  bool activeA = true;
  @override
  void initState() {
    super.initState();
    widget.tabController.animation
      ..addListener(() {
        _currentIndex = widget.tabController.animation.value.round();
        print('_roundedValue: $_currentIndex');
        // TODO: needed? using for setState?
        if (_currentIndex != valueA) {
          activeA = !activeA;

          _previousIndex = valueA;
          print('previousIndex: $_previousIndex');
          valueA = _currentIndex;
          print('valueA: $valueA');
          print('change!!!!');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: kBigBoxPadding,
        right: kBigBoxPadding,
        top: kBigBoxPadding,
        // bottom padding: slide animation when being scrolled
        bottom: bigBoxContainerBottomPadding(context),
      ),
      decoration: BoxDecoration(
        //color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: NestedScrollView(
          controller: widget.scrollController,
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverPadding(
                padding: EdgeInsets.only(top: (kCoverHeightProportion * MediaQuery.of(context).size.height)),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverPersistentHeaderDelegate(
                    Container(
                      width: double.infinity,
                      height: kSliverAppBarLayerHeight,
                      decoration: BoxDecoration(
                          color: colorBackground, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                      child: Stack(children: [
                        AnimatedOpacity(
                          opacity: activeA ? 1 : 0,
                          duration: Duration(milliseconds: activeA ? 1000 : 500),
                          curve: activeA ? Curves.easeInCubic : Curves.easeOutCubic,
                          child: Center(
                            child: Text(
                              activeA ? menu.categories[_currentIndex].title : menu.categories[_previousIndex].title,
                              style: ktsCategoryTitle,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: activeA ? 0 : 1,
                          duration: Duration(milliseconds: activeA ? 500 : 1000),
                          curve: !activeA ? Curves.easeInCubic : Curves.easeOutCubic,
                          child: Center(
                            child: Text(
                              !activeA ? menu.categories[_currentIndex].title : menu.categories[_previousIndex].title,
                              style: ktsCategoryTitle,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: widget.tabController,
            children: [
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 0.52,
                children: _buildGridTileList(
                  context: context,
                  categoryIndex: 0,
                  mealIndex: menu.categories[0].meals.length,
                ),
              ),
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 0.53,
                children: _buildGridTileList(
                  context: context,
                  categoryIndex: 1,
                  mealIndex: menu.categories[1].meals.length,
                ),
              ),
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 0.53,
                children: _buildGridTileList(
                  context: context,
                  categoryIndex: 2,
                  mealIndex: menu.categories[2].meals.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverPersistentHeaderDelegate(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => kSliverAppBarLayerHeight;

  @override
  double get minExtent => kSliverAppBarLayerHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
