import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverAppBarLayer extends SingleChildRenderObjectWidget {
  SliverAppBarLayer({Widget child, Key key}) : super(child: child, key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverAppBarLayer();
  }
}

class RenderSliverAppBarLayer extends RenderSliverToBoxAdapter {
  RenderSliverAppBarLayer({
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
    child.layout(constraints.asBoxConstraints(/* crossAxisExtent: double.infinity */), parentUsesSize: true);
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

    //print('constraints: ${constraints.scrollOffset}');

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: 0,
      paintExtent: childExtent,
      paintOrigin: constraints.scrollOffset,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
    );
    setChildParentData(child, constraints, geometry);
  }
}
