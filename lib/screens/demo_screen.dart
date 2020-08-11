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
                CoverContainer(restaurantTitle: 'Don Juan', imageSrc: 'icons/cover.jpeg'),
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
  final String restaurantTitle;
  CoverContainer({this.imageSrc, this.restaurantTitle});

// ------------------------------------------------

// scroll: ~160
  double backLayerAnimationBottomPoint(BuildContext context) =>
      MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding - bottomTopPointsdiff(context);

// scroll: ~240
  double backLayerAnimationTopPoint(BuildContext context) => MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding;

  // delta btw Top and Bottom points
  double bottomTopPointsdiff(BuildContext context) => computeAnchor(context) / 3.5 * MediaQuery.of(context).size.height;

  // default cover height before we start scrolling
  double defaultCoverHeight(BuildContext context) => (MediaQuery.of(context).size.height) * kCoverHeightProportion + kBigBoxPadding;

  // once we reach the bottom point, the cover starts growing according to this formula
  double growingCoverHeight(BuildContext context) =>
      defaultCoverHeight(context) + Provider.of<ScrollPosition>(context).data - backLayerAnimationBottomPoint(context);

  double coverHeight(BuildContext context) => Provider.of<ScrollPosition>(context).data < backLayerAnimationBottomPoint(context)
      ? defaultCoverHeight(context)
      : Provider.of<ScrollPosition>(context).data < MediaQuery.of(context).size.height
          ? growingCoverHeight(context) // this is the formula
          : MediaQuery.of(context).size.height;

  double completeBlur(BuildContext context) => Provider.of<ScrollPosition>(context).data < backLayerAnimationTopPoint(context)
      ? blur(context, firstPhaseBlur(context))
      : blur(context, finalPhaseMaxBlur(context));

  double blur(BuildContext context, double getFunction) =>
      // handles exception: blur boundary < 0
      Provider.of<ScrollPosition>(context).data < backLayerAnimationBottomPoint(context) ? 0 : getFunction;

  double firstPhaseBlur(BuildContext context) =>
      pow((Provider.of<ScrollPosition>(context).data - backLayerAnimationBottomPoint(context)) * kBlurSpeed, kExponent);

  double finalPhaseMaxBlur(BuildContext context) => pow(bottomTopPointsdiff(context) * kBlurSpeed, kExponent);

  double opacity(BuildContext context) =>
      // handles exceptions: opacity boundary < 0 && opacity bouandary > 1
      completeOpacity(context) < 0 ? 0 : completeOpacity(context) > 1 ? 1 : completeOpacity(context);

  double completeOpacity(BuildContext context) => Provider.of<ScrollPosition>(context).data < backLayerAnimationTopPoint(context)
      ? kCoverColorOpacityCoefficient * blur(context, firstPhaseBlur(context))
      : kCoverColorOpacityCoefficient * blur(context, finalPhaseMaxBlur(context));

  // UNUSED#1: Maybe better keep it simlpe than overdo it, that's why I commented it
  // double calcLastOpacityPhase(BuildContext context) =>
  //     (Provider.of<ScrollPosition>(context).data - MediaQuery.of(context).size.height) * 0.001 + kCoverOpacitySecondStop;

  double restaurantTitleTopPadding(BuildContext context) =>
      kCoverHeightProportion * MediaQuery.of(context).size.height - kRestaurantTitleMaxShadowBlur * 2;

  // ----------------------------- Helper methods -----------------------------------

  Color increaseColorLightness(Color color) => HSVColor.fromColor(color).withValue(0.9).toColor();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: coverHeight(context),
        decoration: BoxDecoration(
          //color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imageSrc),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: completeBlur(context), sigmaY: completeBlur(context)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      increaseColorLightness(colorPrimary1).withOpacity(opacity(context)),
                      increaseColorLightness(colorPrimary1).withOpacity(opacity(context)),
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
        padding: EdgeInsets.only(top: restaurantTitleTopPadding(context), left: kBigBoxPadding),
        child: Text(
          '    ' + restaurantTitle + '    ',
          style: ktsRestaurantTitle,
        ),
      ),
    ]);
  }
}
