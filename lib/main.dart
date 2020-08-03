import 'package:flutter/material.dart';
import 'screens/demo_screen.dart';
import 'screens/grid_screen.dart';
import 'screens/flexible_screen.dart';
import 'screens/fancy_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: Colors.transparent,
      ),
      home: DemoScreen(),
    );
  }
}

// List<Container> _buildGridTileList(int count) => List.generate(
//     count,
//     (i) => Container(
//           decoration: BoxDecoration(
//             color: Colors.blue,
//           ),
//           child: Text('$i / $count'),
//         ));

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(30)),
//         child: CustomScrollView(
//           physics: FixedExtentScrollPhysics(),
//           anchor: 0.3,
//           slivers: [
//             SliverGrid.extent(
//               maxCrossAxisExtent: 150,
//               children: _buildGridTileList(50),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
