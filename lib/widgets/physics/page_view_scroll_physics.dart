import 'package:flutter/material.dart';

class PageViewScrollPhysics extends ScrollPhysics {
  const PageViewScrollPhysics({super.parent});

  @override
  PageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get dragStartDistanceMotionThreshold => 75;

  @override
  double get minFlingDistance => 75;
}
