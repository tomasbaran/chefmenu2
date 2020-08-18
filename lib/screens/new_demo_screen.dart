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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: kTabBarLength, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyScrollPosition>(
      create: (context) => myScrollPosition,
      builder: (context, child) => Scaffold(
        backgroundColor: colorBackground,
        floatingActionButton:
            Provider.of<MyScrollPosition>(context).data > MediaQuery.of(context).size.height ? MyTabBar(_tabController) : Container(),
        //floatingActionButton: MyTabBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            myScrollPosition.updateData(notification.metrics.pixels);
            return true;
          },
          child: Padding(
            padding: EdgeInsets.only(top: topBigBoxPadding(context)),
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverPadding(
                    padding: EdgeInsets.only(top: 300),
                    sliver: SliverAppBar(
                      //stretchTriggerOffset: 200,
                      //collapsedHeight: 100,
                      expandedHeight: 300,
                      pinned: true,
                      floating: true,
                      forceElevated: isScrolled,
                      bottom: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: colorShade2,
                        indicatorColor: Colors.blue,
                        indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
                        tabs: [
                          Tab(
                              icon: Image.asset(
                            'icons/218-bacon-1.png',
                            height: kTabIconHeight, /* color: widget._tabController.index == 0 ? colorTabActive : colorTabInactive */
                          )),
                          Tab(
                              icon: Image.asset(
                            'icons/164-crab.png',
                            height: kTabIconHeight, /*  color: widget._tabController.index == 1 ? colorTabActive : colorTabInactive */
                          )),
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
    );
  }
}
