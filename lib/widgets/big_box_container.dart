import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';

class BigBoxContainer extends StatelessWidget {
  final TabController _tabController;
  BigBoxContainer(this._tabController);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: kBigBoxPadding,
          right: kBigBoxPadding,
          top: kBigBoxPadding,
          bottom: Provider.of<MyScrollPosition>(context).data > (backLayerAnimationTopPoint(context) + kCtaShowtimeDelay)
              ? kBottomBigBoxPadding
              : kBigBoxPadding),
      //bottom: kBottomBigBoxPadding),
      decoration: BoxDecoration(
        //color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: CustomScrollView(
          anchor: topBigBoxPadding(context),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: topBigBoxPadding(context)),
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
                        'Entrantes',
                        style: ktsCategoryTitle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: [
                      Container(height: 300, color: Colors.green),
                      Container(height: 300, color: Colors.red),
                      Container(height: 300, color: Colors.green),
                      Container(height: 300, color: Colors.red),
                      Container(height: 300, color: Colors.green),
                      Container(height: 300, color: Colors.red),
                      Container(height: 300, color: Colors.green),
                    ],
                  ),
                  ListView(
                    children: [
                      Container(height: 300, color: Colors.blue),
                      Container(height: 300, color: Colors.red),
                      Container(height: 300, color: Colors.blue),
                      Container(height: 300, color: Colors.red),
                      Container(height: 300, color: Colors.blue),
                      Container(height: 300, color: Colors.red),
                      Container(height: 300, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            )
            // SliverGrid.extent(
            //   maxCrossAxisExtent: kMaxCrossAxisExtent,
            //   childAspectRatio: 1,
            //   mainAxisSpacing: 0,
            //   crossAxisSpacing: 0,
            //   children: _buildGridTileList(context, 250),
            // ),
          ],
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
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
