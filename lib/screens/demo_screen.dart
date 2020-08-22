import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/widgets/big_box_container.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:chefmenu2/change_notifiers/my_scroll_position.dart';
import 'package:chefmenu2/change_notifiers/tab_index.dart';
import 'package:chefmenu2/widgets/cover_container.dart';
import 'dart:ui';

class DemoScreen extends StatefulWidget {
  static String id = '/demo';

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with SingleTickerProviderStateMixin {
  final MyScrollPosition bigBoxScrollPosition = MyScrollPosition();
  final TabIndex _tabIndex = TabIndex();
  TabController _tabController;
  ScrollController _scrollController;
  bool upDirection = true, flag = true;

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
    return DefaultTabController(
      length: kTabBarLength,
      child: ChangeNotifierProvider<TabIndex>(
        create: (context) => _tabIndex,
        child: ChangeNotifierProvider<MyScrollPosition>(
          create: (context) => bigBoxScrollPosition,
          builder: (context, child) => Scaffold(
            backgroundColor: colorBackground,
            floatingActionButton: upDirection == true ? MyTabBar(_tabController) : Container(),
            //Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context) ? MyTabBar(_tabController) : Container(),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            body: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                //print('dir: ${_scrollController.position.userScrollDirection}');
                if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
                  upDirection = true;
                  print('↑↑↑: $upDirection');
                } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
                  upDirection = false;
                  print('down: $upDirection');
                }

                // Switch active tab bar index when scroll is horizontal
                if (notification.metrics.axis == Axis.horizontal) Provider.of<TabIndex>(context, listen: false).updatePosition(_tabController.index);

                double firstScrollViewHeight = kCoverHeightProportion * MediaQuery.of(context).size.height + kSliverAppBarLayerHeight;

                // formula that counts how much the user scrolls overall (combining the 2 scrollViews) for the blur backlayer animation
                if ((notification.metrics.axis == Axis.vertical) && (notification.depth != 2) && (notification.metrics.extentBefore > 0)) {
                  bigBoxScrollPosition.updateData(notification.metrics.pixels);
                  //print('CHEck stop 1');
                } else if ((notification.metrics.axis == Axis.vertical) &&
                    (notification.depth == 2) &&
                    (notification.metrics.extentBefore > firstScrollViewHeight)) {
                  bigBoxScrollPosition.updateData(notification.metrics.pixels);
                  //print('CHEck stop 2');
                }
                return true;
              },
              child: Stack(
                children: [
                  CoverContainer(restaurantTitle: 'Don Juan', imageSrc: 'icons/cover.jpeg'),
                  //CtaButton(),
                  //DEPRECATED:
                  // Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context)
                  //     ? CtaButton()
                  //     : Align(alignment: Alignment.bottomCenter, child: Container(/* color: Colors.pink ,*/ height: kCtaHeight)),
                  //DEPRECATED:
                  Provider.of<MyScrollPosition>(context).data > (backLayerAnimationTopPoint(context) + kCtaShowtimeDelay) ? CtaButton() : Container(),
                  BigBoxContainer(
                    tabController: _tabController,
                    categoryTitle: Provider.of<TabIndex>(context).position.toString(),
                    scrollController: _scrollController,
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
