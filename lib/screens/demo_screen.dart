import 'package:chefmenu2/animation/cover_aka_back_layer_formulas.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:chefmenu2/widgets/big_box_container.dart';
import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:chefmenu2/animation/my_scroll_position.dart';
import 'package:chefmenu2/widgets/cover_container.dart';

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  final MyScrollPosition myScrollPosition = MyScrollPosition();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 25,
      child: ChangeNotifierProvider<MyScrollPosition>(
        create: (context) => myScrollPosition,
        builder: (context, child) => Scaffold(
          backgroundColor: colorBackground,
          floatingActionButton: Provider.of<MyScrollPosition>(context).data > MediaQuery.of(context).size.height ? MyTabBar() : Container(),
          //floatingActionButton: MyTabBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              //print('A: ${notification.metrics.viewportDimension}');//645
              //print('E1: ${notification.metrics.extentBefore}'); //Before Pixel
              //print('E2: ${notification.metrics.extentInside}');//645
              //print('E3: ${notification.metrics.extentAfter}'); //Still left to the end of Pixel
              // print('START: ${calcContraints(context)}');
              //print('P: ${notification.metrics.pixels}');
              //setState(() {
              myScrollPosition.updateData(notification.metrics.pixels);
              //});

              return true;
            },
            child: Stack(
              children: [
                CoverContainer(restaurantTitle: 'Don Juan', imageSrc: 'icons/cover.jpeg'),
                Provider.of<MyScrollPosition>(context).data > backLayerAnimationTopPoint(context)
                    ? CtaButton()
                    : Align(alignment: Alignment.bottomCenter, child: Container(/* color: Colors.pink ,*/ height: kCtaHeight)),
                //CtaButton(),
                BigBoxContainer(),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Provider.of<MyScrollPosition>(context).data < (backLayerAnimationTopPoint(context) + 69 /* delay for CTA showtime */)
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
