import 'package:flutter/material.dart';
import 'screens/demo_screen.dart';
import 'theme/style_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
