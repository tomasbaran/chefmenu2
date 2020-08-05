import 'package:chefmenu2/theme/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'package:chefmenu2/widgets/sliver_app_bar_layer.dart';

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  // Widget _buildGrid() => GridView.extent(
  //     maxCrossAxisExtent: kMaxCrossAxisExtent,
  //     padding: const EdgeInsets.all(4),
  //     mainAxisSpacing: 4,
  //     crossAxisSpacing: 4,
  //     children: _buildGridTileList(500));

  // List<Widget> tabbarViewItems() {
  //   List<Widget> items = [];
  //   for (int i = 0; i < 25; i++) {
  //     Widget listView = _buildGrid();
  //     items.add(listView);
  //   }
  //   return items;
  // }

  // List<Widget> listViewItems() {
  //   List<Widget> items = [];

  //   for (int i = 0; i < 500; i++) {
  //     Widget widgetItem = Text(
  //       'item $i',
  //       textAlign: TextAlign.center,
  //       style: TextStyle(color: Colors.white),
  //     );
  //     items.add(widgetItem);
  //   }
  //   return items;
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 25,
      child: Scaffold(
        backgroundColor: colorBackground,
        //floatingActionButton: MyTabBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: [
            CoverContainer(
                topPadding: kCoverHeightProportion * MediaQuery.of(context).size.height - 50,
                imageSrc:
                    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80'),
            CtaButton(),
            BigBoxContainer(),
          ],
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
  CoverContainer({this.imageSrc, this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        color: Colors.amber,
        child: Image.network(
          imageSrc,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * kCoverHeightProportion,
        ),
        //color: Colors.green,
      ),
      Padding(
        padding: EdgeInsets.only(top: topPadding, left: kBigBoxPadding),
        child: Text(
          'La casa de don Juan',
          style: ktsRestaurantTitle,
        ),
      )
    ]);
  }
}
