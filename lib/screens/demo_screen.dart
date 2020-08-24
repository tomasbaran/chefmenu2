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

class DemoScreen extends StatefulWidget {
  static String id = '/demo';

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with SingleTickerProviderStateMixin {
  MyScrollPosition bigBoxScrollPosition;
  TabIndex _tabIndex;
  TabController _tabController;
  ScrollController _scrollController;
  bool upDirection = true;

  @override
  void initState() {
    super.initState();
    bigBoxScrollPosition = MyScrollPosition();
    _tabIndex = TabIndex();
    _tabController = TabController(length: kTabBarLength, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    bigBoxScrollPosition.dispose();
    _tabController.dispose();
    _tabIndex.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void updateVerticalScrollDirection(ScrollDirection _scrollDirection) {
    if (_scrollDirection == ScrollDirection.forward) {
      //print('↑↑↑');
      upDirection = true;
    } else if (_scrollDirection == ScrollDirection.reverse) {
      //print('↓↓↓');
      upDirection = false;
    }
  }

  void updateTabBarIndex(Axis _axis, BuildContext context) {
    if (_axis == Axis.horizontal) Provider.of<TabIndex>(context, listen: false).updatePosition(_tabController.index);
  }

  void updateCombinedNestedScroll(ScrollNotification notification, BuildContext context) {
    double firstNestedScrollViewHeight = kCoverHeightProportion * MediaQuery.of(context).size.height + kSliverAppBarLayerHeight;

    if ((notification.metrics.axis == Axis.vertical) && (notification.depth != 2) && (notification.metrics.extentBefore > 0)) {
      //NOTE: originally I had what is commented below but it's probably not correct
      //bigBoxScrollPosition.updateData(notification.metrics.pixels);
      Provider.of<MyScrollPosition>(context, listen: false).updateData(notification.metrics.pixels);
    } else if ((notification.metrics.axis == Axis.vertical) &&
        (notification.depth == 2) &&
        (notification.metrics.extentBefore > firstNestedScrollViewHeight)) {
      //NOTE: originally I had what is commented below but it's probably not correct
      //bigBoxScrollPosition.updateData(notification.metrics.pixels);
      Provider.of<MyScrollPosition>(context, listen: false).updateData(notification.metrics.pixels);
    }
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
            // show tabBar only when being scrolled up ↑↑↑
            floatingActionButton: upDirection ? MyTabBar(_tabController) : Container(),
            //DEPRECATED: shows tabBar only when scrolled to the full screen
            //Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context) ? MyTabBar(_tabController) : Container(),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            body: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // Update vertical scroll direction so tabBar knows when to show/hide
                updateVerticalScrollDirection(_scrollController.position.userScrollDirection);
                // Update/setState/rebuild active tab bar index (when scroll is horizontal)
                updateTabBarIndex(notification.metrics.axis, context);
                // formula that counts how much the user scrolls overall (combining the 2 scrollViews) for the blur backlayer animation
                updateCombinedNestedScroll(notification, context);
                return true;
              },
              child: Stack(
                children: [
                  CoverContainer(restaurantTitle: 'Don Juan', imageSrc: 'icons/cover.jpeg'),
                  //DEPRECATED:
                  // Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context)
                  //     ? CtaButton()
                  //     : Align(alignment: Alignment.bottomCenter, child: Container(/* color: Colors.pink ,*/ height: kCtaHeight)),
                  //WORKAROUND of a simple CtaButton(): because pure simple CtaButton() causes strange issues of different sorts
                  //CtaButton(),
                  Provider.of<MyScrollPosition>(context).data > 0 /* (backLayerAnimationTopPoint(context) + kCtaShowtimeDelay) */ ? CtaButton()
                      : Container(),
                  BigBoxContainer(
                      categoryTitle: Provider.of<TabIndex>(context).position.toString(),
                      tabController: _tabController,
                      scrollController: _scrollController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
