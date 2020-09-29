import 'package:flutter/material.dart';
import 'screens/demo_screen.dart';
import 'theme/style_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //TODO: Install firebase analytics
  FirebaseAnalytics analytics = FirebaseAnalytics();

  ImageProvider logo = AssetImage('img/0/0.jpg');
  @override
  Widget build(BuildContext context) {
    precacheImage(logo, context);
    return MaterialApp(
      //TODO: Install firebase analytics
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
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
