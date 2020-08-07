import 'dart:math';
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
                CoverContainer(imageSrc: 'icons/cover.jpeg'),
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
  final String imageSrc;
  CoverContainer({this.imageSrc});

  // REFACTOR: down from here  ↓

// scroll: ~160
  double bottomPointForBackLayerAnimation(BuildContext context) =>
      MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding - kStartPoint(context);

// scroll: ~240
  double topPointForBackLayerAnimation(BuildContext context) => MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding;

  double calcHeight(BuildContext context) => Provider.of<ScrollPosition>(context).data < bottomPointForBackLayerAnimation(context)
      ? MediaQuery.of(context).size.height * kCoverHeightProportion
      : Provider.of<ScrollPosition>(context).data < MediaQuery.of(context).size.height
          ? MediaQuery.of(context).size.height * kCoverHeightProportion +
              Provider.of<ScrollPosition>(context).data -
              bottomPointForBackLayerAnimation(context) // this is the formula
          : MediaQuery.of(context).size.height;

  double calcBlurFirstPhase(BuildContext context) => pow(
      (Provider.of<ScrollPosition>(context).data - bottomPointForBackLayerAnimation(context) < 0
              ? 0
              : Provider.of<ScrollPosition>(context).data - bottomPointForBackLayerAnimation(context)) *
          kBlurSpeed,
      kExponent);

// REFACTOR: up from here  ↑
  double calcBlurFinalPhase(BuildContext context) => pow(kStartPoint(context) * kBlurSpeed, kExponent);

  double handleLowerBlurBoundary(BuildContext context) =>
      Provider.of<ScrollPosition>(context).data < bottomPointForBackLayerAnimation(context) ? 0 : calcAllBlurPhases(context);

  double calcAllBlurPhases(BuildContext context) => Provider.of<ScrollPosition>(context).data < topPointForBackLayerAnimation(context)
      ? calcBlurFirstPhase(context)
      : calcBlurFinalPhase(context); //maxBlur

  double calcAllOpacityPhases(BuildContext context) => Provider.of<ScrollPosition>(context).data < topPointForBackLayerAnimation(context)
      ? kCoverColorOpacityCoefficient * calcBlurFirstPhase(context) //this is the formula
      : kCoverColorOpacityCoefficient * calcBlurFinalPhase(context);

  double handleOpacityBoundaries(BuildContext context) =>
      calcAllOpacityPhases(context) < 0 ? 0 : calcAllOpacityPhases(context) > 1 ? 1 : calcAllOpacityPhases(context);

  // UNUSED#1: Maybe better keep it simlpe than overdo it, that's why I commented it
  // double calcLastOpacityPhase(BuildContext context) =>
  //     (Provider.of<ScrollPosition>(context).data - MediaQuery.of(context).size.height) * 0.001 + kCoverOpacitySecondStop;

  double topPadding(BuildContext context) => kCoverHeightProportion * MediaQuery.of(context).size.height - 30 - kRestaurantTitleMaxShadowBlur;

  // ----------------------------- Helper methods -----------------------------------

  Color increaseColorLightness(Color color) => HSVColor.fromColor(color).withValue(0.75).toColor();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: calcHeight(context),
        decoration: BoxDecoration(
          // color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imageSrc),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: calcAllBlurPhases(context), sigmaY: calcAllBlurPhases(context)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      increaseColorLightness(colorPrimary1).withOpacity(handleOpacityBoundaries(context)),
                      increaseColorLightness(colorPrimary1).withOpacity(handleOpacityBoundaries(context)),
                      increaseColorLightness(colorPrimary1).withOpacity(0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0,
                      // UNUSED#1: Maybe better keep it simlpe than overdo it, that's why I commented it
                      // Provider.of<ScrollPosition>(context).data < (MediaQuery.of(context).size.height)
                      //     ? kCoverOpacitySecondStop : calcLastOpacityPhase(context) < 1 ? calcLastOpacityPhase(context) : 1,
                      kCoverOpacitySecondStop,
                      1
                    ])),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: topPadding(context), left: kBigBoxPadding),
        child: Text(
          '   ' + 'Don Juan' + '   ',
          style: ktsRestaurantTitle,
        ),
      ),
    ]);
  }
}
