import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/widgets/gradient_background_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150, padding: const EdgeInsets.all(4), mainAxisSpacing: 4, crossAxisSpacing: 4, children: _buildGridTileList(500));

  List<Container> _buildGridTileList(int count) => List.generate(count, (i) => Container(child: Text('$i'), color: Colors.blue));

  List<Widget> tabbarViewItems() {
    List<Widget> items = [];
    for (int i = 0; i < 25; i++) {
      Widget listView = _buildGrid();
      items.add(listView);
    }
    return items;
  }

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
        floatingActionButton: MyTabBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GradientBackgroundWrapper(
          child: ListView(children: [
            Container(
              height: MediaQuery.of(context).size.height * kCoverHeightProportion,
              color: Colors.green,
              //decoration: BoxDecoration(borderRadius: Border),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: TabBarView(
                children: tabbarViewItems(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
