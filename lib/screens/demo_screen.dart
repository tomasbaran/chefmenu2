import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';

class DemoScreen extends StatelessWidget {
  static String id = '/demo';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 800,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.grey),
            child: TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.pink,
              indicatorColor: Colors.white,
              indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.white),
              tabs: [
                Tab(
                    icon: CustomIcon(
                  'icons/001-sausage-2.svg',
                  height: 28,
                )

                    /* SvgPicture.asset(
                    'icons/001-sausage-2.svg',
                    semanticsLabel: 'Acme Logo',
                    height: 28,
                    color: Colors.orange,
                  ), */
                    ),
                Tab(icon: Icon(Icons.email)),
              ],
            ),
          ),
        ),
        body: Center(
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

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.name, {
    Key key,
    this.height,
    this.color,
  }) : super(key: key);

  final String name;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;

    if (iconOpacity != 1.0) iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    return SvgPicture.asset(
      name,
      color: iconColor,
      height: height,
    );
  }
}
