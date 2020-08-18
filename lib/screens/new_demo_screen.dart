import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/widgets/big_box_container.dart';
import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:chefmenu2/animation/my_scroll_position.dart';
import 'package:chefmenu2/widgets/cover_container.dart';

class NewDemoScreen extends StatefulWidget {
  static String id = '/demo';

  @override
  _NewDemoScreenState createState() => _NewDemoScreenState();
}

class _NewDemoScreenState extends State<NewDemoScreen> with SingleTickerProviderStateMixin {
  final MyScrollPosition myScrollPosition = MyScrollPosition();
  TabController _tabController;
  //ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: kTabBarLength, vsync: this);
    //TODO: remove _scrollController: no need for it
    //_scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /* ChangeNotifierProvider<MyScrollPosition>(
      create: (context) => myScrollPosition,
      builder: (context, child) =>  */
        Scaffold(
      //backgroundColor: colorBackground,
      floatingActionButton: Provider.of<MyScrollPosition>(context).data > MediaQuery.of(context).size.height ? MyTabBar(_tabController) : Container(),
      //floatingActionButton: MyTabBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          myScrollPosition.updateData(notification.metrics.pixels);
          return true;
        },
        child: Container(
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
            child: NestedScrollView(
              //controller: _scrollController,
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
                              'Entrantes',
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
            ),
          ),
        ),
      ),
    ) /* ,
    ) */
        ;
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
