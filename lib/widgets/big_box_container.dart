import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
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

  int numberOfRows(int meals, int columns) {
    int increaseRows;
    // if (an item started a row) or (there is only 1 row) -> increaseRows
    (meals % columns != 0) ? increaseRows = 1 : increaseRows = 0;
    ((meals / columns).floor()) == 0 ? increaseRows = 2 : null;

    int output;
    if ((meals / columns).floor() + increaseRows < 2)
      output = 2;
    else
      output = (meals / columns).floor() + increaseRows;

    return output;
  }

  int numberOfItems(int rows, int columns) => rows * columns;

  List<Widget> _buildGridTileList({dynamic context, int meals, int categoryIndex}) {
    // +1 because the columns starts counting from 0
    int columns = numberOfColumns(context) + 1;
    //print('columns: $columns');
    int rows = numberOfRows(meals, columns);
    //print('rows: $rows');
    int numberOfGrids = numberOfItems(rows, columns);
    //print('numberOfGrids: $numberOfGrids');
    return List.generate(numberOfGrids, (i) {
      if (i >= meals)
        return showEmptyContainer(i, numberOfGrids);
      else
        return showMealCard(i, context, categoryIndex);
    });
  }

  MealCard showMealCard(int i, context, int categoryIndex) {
    return MealCard(
      i: i,
      numberOfColumns: numberOfColumns(context),
      title: menu.categories[categoryIndex].meals[i].title,
      portion: menu.categories[categoryIndex].meals[i].portion,
      price: menu.categories[categoryIndex].meals[i].price,
      imageUrl: menu.categories[categoryIndex].meals[i].imageUrl,
      //currency: meals[0].currency,
      ingredients: menu.categories[categoryIndex].meals[i].ingredients,
    );
  }

  Container showEmptyContainer(int i, int numberOfGrids) {
    return Container(
      //NOTE: workaround according to: https://github.com/flutter/flutter/issues/25009
      decoration: BoxDecoration(
        color: colorBackground, //the color of the main container
        border: Border.all(
          //apply border to only that side where the line is appearing i.e. top | bottom | right | left.
          width: 4, //depends on the width of the unintended line
          color: colorBackground,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorBackground,
        ),
        // child: Center(
        //   child: Text(
        //     '${i + 1} / $numberOfGrids',
        //     style: TextStyle(color: Colors.grey),
        //     //textAlign: TextAlign.center,
        //   ),
        // ),
      ),
    );
  }

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
  int _nextIndex = 0;
  bool _stackAIsActive = true;

  void _changeTabIndex() {
    widget.tabController.animation
      ..addListener(() {
        _currentIndex = widget.tabController.animation.value.round();
        //print('_previousIndex: $_previousIndex');
        //print('_currentIndex: $_currentIndex');
        //print('_nextIndex: $_nextIndex');

        if (_currentIndex != _nextIndex) {
          // _stackAIsActive ? stackA is active : stackB is active
          _stackAIsActive = !_stackAIsActive;

          _previousIndex = _nextIndex;
          //print('previousIndex: $_previousIndex');
          _nextIndex = _currentIndex;
          //print('_nextIndex: $_nextIndex');

          //print('change!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

        }
      });
  }

  @override
  void initState() {
    super.initState();
    _changeTabIndex();
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
                        // StackA
                        AnimatedOpacity(
                          opacity: _stackAIsActive ? 1 : 0,
                          duration: Duration(milliseconds: _stackAIsActive ? 1000 : 500),
                          curve: _stackAIsActive ? Curves.easeInCubic : Curves.easeOutCubic,
                          child: Center(
                            child: Text(
                              _stackAIsActive ? menu.categories[_currentIndex].title : menu.categories[_previousIndex].title,
                              style: ktsCategoryTitle,
                            ),
                          ),
                        ),
                        // StackB
                        AnimatedOpacity(
                          opacity: !_stackAIsActive ? 1 : 0,
                          duration: Duration(milliseconds: !_stackAIsActive ? 1000 : 500),
                          curve: !_stackAIsActive ? Curves.easeInCubic : Curves.easeOutCubic,
                          child: Center(
                            child: Text(
                              !_stackAIsActive ? menu.categories[_currentIndex].title : menu.categories[_previousIndex].title,
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
              Container(
                child: GridView.extent(
                  maxCrossAxisExtent: kMaxCrossAxisExtent,
                  childAspectRatio: 0.44,
                  children: _buildGridTileList(
                    context: context,
                    categoryIndex: 0,
                    meals: menu.categories[0].meals.length,
                  ),
                ),
              ),
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 0.52,
                children: _buildGridTileList(
                  context: context,
                  categoryIndex: 1,
                  meals: menu.categories[1].meals.length,
                ),
              ),
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 0.53,
                children: _buildGridTileList(
                  context: context,
                  categoryIndex: 2,
                  meals: menu.categories[2].meals.length,
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
