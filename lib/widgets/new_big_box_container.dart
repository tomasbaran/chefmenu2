import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/change_notifiers/tab_index.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/widgets/big_box_container.dart';
import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';
import 'package:chefmenu2/widgets/cover_container.dart';

class NewBigBoxContainer extends StatelessWidget {
  int computeNumberOfColumns(dynamic context) => ((MediaQuery.of(context).size.width - (2 * kBigBoxPadding)) / kMaxCrossAxisExtent).floor();
  List<Container> _buildGridTileList(dynamic context, int count) => List.generate(
      count,
      (i) => Container(
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

              child: Center(
                child: Text(
                  '$i / ${computeNumberOfColumns(context)}',
                  style: TextStyle(color: Colors.grey),
                  //textAlign: TextAlign.center,
                ),
              ),
              //margin: EdgeInsets.all(0),
            ),
          ));

  final TabController tabController;
  final String categoryTitle;
  NewBigBoxContainer({this.tabController, this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: kBigBoxPadding,
          right: kBigBoxPadding,
          top: kBigBoxPadding,
          //ternary operators: for the bottom scroll up animation
          bottom: (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context)) >= kBottomBigBoxPadding
              ? kBottomBigBoxPadding
              : Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context)
                  ? kBigBoxPadding + (Provider.of<MyScrollPosition>(context).data - backLayerAnimationTopPoint(context))
                  : kBigBoxPadding),
      //bottom: kBottomBigBoxPadding),
      decoration: BoxDecoration(
        //color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: NestedScrollView(
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
                      child: Center(
                        child: Text(
                          //_tabController.index == 0 ? 'Entrantes' : 'Main Courses',
                          //Provider.of<TabIndex>(context).position.toString(),
                          categoryTitle,
                          style: ktsCategoryTitle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children: _buildGridTileList(context, 250),
              ),
              GridView.extent(
                maxCrossAxisExtent: kMaxCrossAxisExtent,
                childAspectRatio: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children: _buildGridTileList(context, 250),
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
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
