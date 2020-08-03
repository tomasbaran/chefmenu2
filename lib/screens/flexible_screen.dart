import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

class PercentageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: MyDynamicHeader(),
          ),
          SliverTomas(
            child: Placeholder(
              fallbackHeight: 600,
              fallbackWidth: 300,
            ),
          ),
        ],
      ),
    );
  }
}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  // dynamic croppedImage = NetworkImage(
  //     'https://images.unsplash.com/photo-1561752888-21eb3b67eb4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80');

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final Color color = Colors.blue;
      final double percentage = (minExtent - constraints.maxHeight) / (maxExtent - minExtent);

      if (++index > Colors.primaries.length - 1) index = 0;

      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1561752888-21eb3b67eb4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80'),
              fit: BoxFit.cover),
          boxShadow: [BoxShadow(blurRadius: 100, color: Colors.black45)],
        ),
        height: constraints.maxHeight,
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Text(percentage.toString()),
              CircularProgressIndicator(
                value: percentage,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        )),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;
}

class SliverTomas extends SingleChildRenderObjectWidget {
  SliverTomas({Widget child, Key key}) : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return RenderSliverTomas();
  }
}

class RenderSliverTomas extends RenderSliverToBoxAdapter {
  RenderSliverTomas({
    RenderBox child,
  }) : super(child: child);

  @override
  void performResize() {}

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child.layout(constraints.asBoxConstraints(crossAxisExtent: 200), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        childExtent = child.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent = calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );
    setChildParentData(child, constraints, geometry);
  }
}
