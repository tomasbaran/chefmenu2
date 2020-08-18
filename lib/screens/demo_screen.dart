import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/widgets/new_big_box_container.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/widgets/big_box_container.dart';
import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:chefmenu2/animation/my_scroll_position.dart';
import 'package:chefmenu2/widgets/cover_container.dart';

class DemoScreen extends StatefulWidget {
  static String id = '/demo';

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with SingleTickerProviderStateMixin {
  final MyScrollPosition bigBoxScrollPosition = MyScrollPosition();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: kTabBarLength, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kTabBarLength,
      child: ChangeNotifierProvider<MyScrollPosition>(
        create: (context) => bigBoxScrollPosition,
        builder: (context, child) => Scaffold(
          backgroundColor: colorBackground,
          floatingActionButton:
              Provider.of<MyScrollPosition>(context).data > MediaQuery.of(context).size.height ? MyTabBar(_tabController) : Container(),
          //floatingActionButton: MyTabBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              //double konstanta = 475;
              double konstanta = kCoverHeightProportion * MediaQuery.of(context).size.height + kSliverAppBarLayerHeight;
              print('konstanta: $konstanta');
              if ((notification.metrics.axis == Axis.vertical) && (notification.depth != 2) && (notification.metrics.pixels > 0)) {
                bigBoxScrollPosition.updateData(notification.metrics.pixels);
              } else if ((notification.metrics.axis == Axis.vertical) && (notification.depth == 2) && (notification.metrics.pixels > 0)) {
                bigBoxScrollPosition.updateData(notification.metrics.pixels + konstanta);
              }
              return true;
            },
            child: Stack(
              children: [
                CoverContainer(restaurantTitle: 'Don Juan', imageSrc: 'icons/cover.jpeg'),
                Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context)
                    ? CtaButton()
                    : Align(alignment: Alignment.bottomCenter, child: Container(/* color: Colors.pink ,*/ height: kCtaHeight)),
                //CtaButton(),
                //BigBoxContainer(_tabController),
                NewBigBoxContainer(),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Provider.of<MyScrollPosition>(context).data < (backLayerAnimationTopPoint(context) + kCtaShowtimeDelay )
                //         ? Container(color: colorBackground, height: kBottomBigBoxPadding)
                //         : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
