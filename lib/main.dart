import 'package:flutter/material.dart';
import 'screens/demo_screen.dart';
import 'screens/grid_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoScreen(),
    );
  }
}
