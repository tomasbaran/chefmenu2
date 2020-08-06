import 'dart:ui';

import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:chefmenu2/widgets/sliver_app_bar_layer.dart';
import 'package:provider/provider.dart';

class ScrollPosition extends ChangeNotifier {
  double data = 0;

  updateData(double newData) {
    data = newData;
    notifyListeners();
  }
}

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  final ScrollPosition scrollPosition = ScrollPosition();

  //double topPadding() => kCoverHeightProportion * MediaQuery.of(context).size.height - 50 - kShadowBlur;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 25,
      child: ChangeNotifierProvider<ScrollPosition>(
        create: (context) => scrollPosition,
        child: Scaffold(
          backgroundColor: colorBackground,
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
              scrollPosition.updateData(notification.metrics.pixels);
              //});

              return true;
            },
            child: Stack(
              children: [
                CoverContainer(
                    topPadding: kCoverHeightProportion * MediaQuery.of(context).size.height - 50 - kShadowBlur, imageSrc: 'icons/cover.jpeg'),
                CtaButton(),
                BigBoxContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BigBoxContainer extends StatelessWidget {
  int computeNumberOfColumns(dynamic context) => ((MediaQuery.of(context).size.width - (2 * kBigBoxPadding)) / kMaxCrossAxisExtent).floor();

  double computeAnchor(dynamic context) =>
      kCoverHeightProportion *
      kCoverHeightProportion *
      MediaQuery.of(context).size.height /
      (kCoverHeightProportion * (MediaQuery.of(context).size.height - kBigBoxPadding - kBottomBigBoxPadding));

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
      margin: EdgeInsets.only(left: kBigBoxPadding, right: kBigBoxPadding, top: kBigBoxPadding, bottom: kBottomBigBoxPadding),
      decoration: BoxDecoration(
        //color: Colors.pink,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: CustomScrollView(
          anchor: computeAnchor(context),
          slivers: [
            SliverAppBarLayer(
              child: Container(
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
            SliverGrid.extent(
              maxCrossAxisExtent: kMaxCrossAxisExtent,
              childAspectRatio: 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: _buildGridTileList(context, 250),
            ),
          ],
        ),
      ),
    );
  }
}

class CtaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: kBigBoxPadding),
        height: kCtaHeight,
        width: kCtaWidth,
        decoration: BoxDecoration(color: colorCtaBackground, borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Center(
          child: Text(
            'CREAR MENÚ',
            style: ktsCta,
          ),
        ),
      ),
    );
  }
}

class CoverContainer extends StatelessWidget {
  final double topPadding;
  final String imageSrc;

  double calcContraints(dynamic context) => MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding;

  CoverContainer({this.imageSrc, this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          color: colorBackground.withOpacity(0),
          child: Image.asset(
            imageSrc,
            fit: BoxFit.cover,
            height: Provider.of<ScrollPosition>(context).data < calcContraints(context)
                ? MediaQuery.of(context).size.height * kCoverHeightProportion
                : MediaQuery.of(context).size.height * kCoverHeightProportion + Provider.of<ScrollPosition>(context).data - 244,
            isAntiAlias: true,
          ),
          //color: Colors.green,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: topPadding, left: kBigBoxPadding),
        child: Text(
          '  ' + 'La casa de don Juan' + '  ',
          style: ktsRestaurantTitle,
        ),
      ),
      Text(
        Provider.of<ScrollPosition>(context).data.toString(),
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }
}
