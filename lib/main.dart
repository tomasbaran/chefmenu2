import 'package:flutter/material.dart';
import 'screens/demo_screen.dart';
import 'theme/style_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //TODO: Install firebase analytics
  //FirebaseAnalytics analytics = FirebaseAnalytics();

  ImageProvider logo = AssetImage('img/0/0.jpg');
  @override
  Widget build(BuildContext context) {
    precacheImage(logo, context);
    return MaterialApp(
      //TODO: Install firebase analytics
      //navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      theme: ThemeData(
        // Android claming colors
        accentColor: colorBackground.withOpacity(0.01),
        //accentColorBrightness: Brightness.light,

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
