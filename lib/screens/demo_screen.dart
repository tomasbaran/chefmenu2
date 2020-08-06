import 'dart:ui';

import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:chefmenu2/widgets/sliver_app_bar_layer.dart';

class DemoScreen extends StatefulWidget {
  static String id = '/demo';

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  double scrollPosition = 0;

  double calcContraints(dynamic context) => MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding;

  double topPadding() => kCoverHeightProportion * MediaQuery.of(context).size.height - 50 - kShadowBlur;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 25,
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
            print('P: ${notification.metrics.pixels}');
            //setState(() {
            scrollPosition = notification.metrics.pixels;
            //});

            return true;
          },
          child: Stack(
            children: [
              // CoverContainer(
              //     scrollPosition: scrollPosition,
              //     topPadding: kCoverHeightProportion * MediaQuery.of(context).size.height - 50 - kShadowBlur,
              //     imageSrc: 'icons/cover.jpeg'),

              Stack(children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: double.infinity,
                    color: colorBackground.withOpacity(0),
                    child: Image.asset(
                      'icons/cover.jpeg',
                      fit: BoxFit.cover,
                      height: scrollPosition < calcContraints(context)
                          ? MediaQuery.of(context).size.height * kCoverHeightProportion
                          : MediaQuery.of(context).size.height * kCoverHeightProportion + scrollPosition - 244,
                      isAntiAlias: true,
                    ),
                    //color: Colors.green,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: topPadding(), left: kBigBoxPadding),
                  child: Text(
                    '  ' + 'La casa de don Juan' + '  ',
                    style: ktsRestaurantTitle,
                  ),
                ),
                ScrollText(scrollPosition: scrollPosition),
              ]),
              CtaButton(),
              BigBoxContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollText extends StatefulWidget {
  const ScrollText({
    Key key,
    @required this.scrollPosition,
  }) : super(key: key);

  final double scrollPosition;

  @override
  _ScrollTextState createState() => _ScrollTextState();
}

class _ScrollTextState extends State<ScrollText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.scrollPosition.toString(),
      style: TextStyle(color: Colors.white),
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
    return NotificationListener<ScrollNotification>(
      child: Container(
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
  final double scrollPosition;

  double calcContraints(dynamic context) => MediaQuery.of(context).size.height * kCoverHeightProportion - kBigBoxPadding;

  CoverContainer({this.imageSrc, this.topPadding, this.scrollPosition});

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
            height: scrollPosition < calcContraints(context)
                ? MediaQuery.of(context).size.height * kCoverHeightProportion
                : MediaQuery.of(context).size.height * kCoverHeightProportion + scrollPosition - 244,
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
      // Text(
      //   scrollPosition.toString(),
      //   style: TextStyle(color: Colors.white),
      // ),
    ]);
  }
}
