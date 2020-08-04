import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/widgets/gradient_background_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';
import 'flexible_screen.dart';

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  int numberOfColumns(dynamic context) => ((MediaQuery.of(context).size.width - (2 * kBigBoxPadding)) / kMaxCrossAxisExtent).floor();

  // Widget _buildGrid() => GridView.extent(
  //     maxCrossAxisExtent: kMaxCrossAxisExtent,
  //     padding: const EdgeInsets.all(4),
  //     mainAxisSpacing: 4,
  //     crossAxisSpacing: 4,
  //     children: _buildGridTileList(500));

  List<Container> _buildGridTileList(dynamic context, int count) => List.generate(
      count,
      (i) => Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(/* i == numberOfColumns(context) ? 30 : */ 1), /* topLeft: Radius.circular(i == 0 ? 30 : ) */
              ),
            ),

            child: Center(
              child: Text(
                '$i / ${numberOfColumns(context)}',
                style: TextStyle(color: Colors.grey),
                //textAlign: TextAlign.center,
              ),
            ),
            //margin: EdgeInsets.all(0),
          ));

  // List<Widget> tabbarViewItems() {
  //   List<Widget> items = [];
  //   for (int i = 0; i < 25; i++) {
  //     Widget listView = _buildGrid();
  //     items.add(listView);
  //   }
  //   return items;
  // }

  List<Widget> listViewItems() {
    List<Widget> items = [];

    for (int i = 0; i < 500; i++) {
      Widget widgetItem = Text(
        'item $i',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      );
      items.add(widgetItem);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 25,
      child: Scaffold(
        //floatingActionButton: MyTabBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GradientBackgroundWrapper(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.amber,
                child: Image.network(
                  'https://images.unsplash.com/photo-1561752888-21eb3b67eb4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * kCoverHeightProportion,
                ),
                //color: Colors.green,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  width: 300,
                  color: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(left: kBigBoxPadding, right: kBigBoxPadding, top: kBigBoxPadding, bottom: kBottomBigBoxPadding),

                  //width: MediaQuery.of(context).size.width * 0.9,
                  //margin: EdgeInsets.symmetric(horizontal: kBigBoxPadding),
                  decoration: BoxDecoration(
                    //color: Colors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: CustomScrollView(
                      //physics: FixedExtentScrollPhysics(),
                      anchor: kCoverHeightProportion *
                          kCoverHeightProportion *
                          MediaQuery.of(context).size.height /
                          (kCoverHeightProportion * (MediaQuery.of(context).size.height - kBigBoxPadding - kBottomBigBoxPadding)),
                      slivers: [
                        SliverTomas(
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                          ),
                        ),
                        SliverGrid.extent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          children: _buildGridTileList(context, 50),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
