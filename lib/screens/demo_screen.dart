import 'package:chefmenu2/theme/style_constants.dart';
import 'package:chefmenu2/widgets/gradient_background_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/widgets/my_tab_bar.dart';

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 25,
      child: Scaffold(
        floatingActionButton: MyTabBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GradientBackgroundWrapper(
          child: ListView(
            children: [
              Container(width: double.infinity),
              Text(
                'La casa de don Juan',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 100),
              Text(
                'Beef',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 100),
              Text('Meal Cards'),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
              Text('La casa de don Juan'),
              SizedBox(height: 100),
              Text('Beef'),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
