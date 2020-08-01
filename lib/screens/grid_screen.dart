import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150, padding: const EdgeInsets.all(4), mainAxisSpacing: 4, crossAxisSpacing: 4, children: _buildGridTileList(30));

// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
// The List.generate() constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (i) => Container(
            child: Text('index: $i'),
            color: Colors.red,
          ));

  @override
  Widget build(BuildContext context) {
    return _buildGrid();
  }
}
