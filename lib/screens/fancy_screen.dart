import 'package:flutter/material.dart';
import 'dart:math';
import 'flexible_screen.dart';

class FancyScreen extends StatefulWidget {
  @override
  _FancyScreenState createState() => _FancyScreenState();
}

class _FancyScreenState extends State<FancyScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: Image.network(
                  'https://images.unsplash.com/photo-1561752888-21eb3b67eb4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          // Positioned.fill(
          //   top: 20,
          //   child: CustomScrollView(slivers: [
          //     SliverList(delegate: SliverChildBuilderDelegate(
          //       (BuildContext context, int index) {
          //         return Container(
          //           height: 200,
          //           color: Color(Random().nextInt(0xffffffff)),
          //         );
          //       },
          //     )),
          //   ]),
          // ),
          Positioned.fill(
            top: 30,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.pink,
                //width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    SizedBox(height: 300),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                    Text('r'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
