import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InfinitelyScrollableNavigationBar extends StatefulWidget {
  final List<IconData> icons;
  final List<String> labels;
  final Function(int index) handler;

  const InfinitelyScrollableNavigationBar(this.icons, this.labels, this.handler,
      {super.key});
  @override
  _InfinitelyScrollableNavigationBarState createState() =>
      _InfinitelyScrollableNavigationBarState();
}

class _InfinitelyScrollableNavigationBarState
    extends State<InfinitelyScrollableNavigationBar> {
  List<Widget> stackChildren = [];
  Map<int, double> opacities = {};
  Map<int, double> alignments = {};

  double spacing = 0;
  int childrenCount = 0;
  int currentSelectedIndex = 0;
  double maxAlignmentPosition = 0;
  Duration duration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();

    childrenCount = widget.icons.length;
    if (childrenCount < 3) throw Exception("Minimum 3 children required");
    if (childrenCount > 5) throw Exception("Maximum 5 children required");
    spacing =
        (childrenCount % 2 == 0 ? 2 / (childrenCount + 1) : 2 / childrenCount)
            .toPrecision(2);
    currentSelectedIndex = childrenCount ~/ 2;
    maxAlignmentPosition = spacing * childrenCount - spacing / childrenCount;

    _setInitialChildrenAlignments();
    _setInitialChildrenOpacities();
    _generateStackChildren();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _tapProvider,
      onHorizontalDragEnd: _horizontalDragProvider,
      child: Container(
        height: 80,
        width: double.infinity,
        color: Colors.transparent.withAlpha(25),
        child: Stack(children: stackChildren),
      ),
    );
  }

  void _generateStackChildren() {
    stackChildren = [
      for (int ix = 0; ix < widget.icons.length * 2; ix++)
        Opacity(
          opacity: opacities[ix]!,
          child: AnimatedAlign(
            alignment: Alignment(alignments[ix]!, 0),
            duration: duration,
            child: Stack(
              alignment: Alignment(alignments[ix]!, 0),
              children: [
                AnimatedAlign(
                  duration: duration,
                  alignment:
                      alignments[ix]!.abs() <= 0.1 && ix == currentSelectedIndex
                          ? Alignment(alignments[ix]!, -0.5)
                          : Alignment(alignments[ix]!, 0),
                  child: AnimatedContainer(
                    duration: duration,
                    alignment: Alignment.center,
                    width: 55,
                    height: 35,
                    decoration: BoxDecoration(
                      color: alignments[ix]!.abs() <= 0.1 &&
                              ix == currentSelectedIndex
                          ? Colors.blueAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AnimatedScale(
                      child: Icon(widget.icons[ix % widget.icons.length]),
                      scale: alignments[ix]!.abs() <= 0.1 &&
                              ix == currentSelectedIndex
                          ? 1.25
                          : 1,
                      duration: duration,
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: duration,
                  alignment: alignments[currentSelectedIndex]!.abs() <= 0.1 &&
                          ix == currentSelectedIndex
                      ? Alignment(0, 0.75)
                      : Alignment(0, 2),
                  child: Text(
                    widget.labels[ix % widget.labels.length],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    ];
  }

  void _setInitialChildrenAlignments() {
    double startingPosition = -1 + spacing / 2;
    alignments = Map.fromIterable(
      Iterable<int>.generate(childrenCount * 2),
      key: (ix) => ix,
      value: (ix) => ix >= (3 * childrenCount) ~/ 2
          ? startingPosition - spacing * (childrenCount * 2 - ix)
          : startingPosition + (spacing * ix),
    );
  }

  void _updateChildrenAlignments(double velocity) {
    alignments.updateAll(
      (key, value) => value * velocity.sign >= maxAlignmentPosition
          ? -value + (spacing * velocity.sign)
          : value + (spacing * velocity.sign),
    );
  }

  void _setInitialChildrenOpacities() {
    opacities = Map<int, double>.fromIterable(
      Iterable<int>.generate(childrenCount * 2),
      key: (ix) => ix,
      value: (ix) => 1,
    );
  }

  void _updateChildrenOpacities() {
    opacities.updateAll(
      (key, value) =>
          alignments[key]!.abs() + (childrenCount <= 4 ? 0 : spacing) >=
                  maxAlignmentPosition
              ? 0
              : 1,
    );
  }

  void _updateCurrentSelectedIndex(double velocity) {
    currentSelectedIndex =
        velocity > 0 ? currentSelectedIndex - 1 : currentSelectedIndex + 1;

    currentSelectedIndex = currentSelectedIndex % (childrenCount * 2);
  }

  void _horizontalDragProvider(DragEndDetails details) {
    // Find the velocity of the drag
    double velocity = details.primaryVelocity!;
    if (velocity == 0) return;

    // Update the alignments, opacities & selected index
    _updateCurrentSelectedIndex(velocity);
    _updateChildrenOpacities();
    _updateChildrenAlignments(velocity);
    _generateStackChildren();
    setState(() {});

    widget.handler(alignments.keys
            .firstWhere((key) => alignments[key]!.toPrecision(1).abs() <= 0.1) %
        widget.icons.length);
  }

  void _tapProvider(TapUpDetails details) async {
    // Find the selected index
    double selectedAlignment = (details.localPosition.dx / Get.width * 2 - 1);
    int selectedIndex = alignments.keys.firstWhere(
      (ix) => (selectedAlignment - alignments[ix]!).abs() <= 0.2,
      orElse: () => -1,
    );

    // If no index is found or the selected index is already selected
    if (selectedIndex == -1)
      return;
    else if (alignments[selectedIndex]!.toPrecision(1).abs() <= 0.1) return;

    // Update the selected index
    Duration previousDuration = duration;
    int previousSelectedIndex = currentSelectedIndex;
    currentSelectedIndex = selectedIndex;

    _generateStackChildren();
    setState(() {});

    // If the selected index is not adjacent to the previous selected index then change the duration
    if ((selectedIndex - previousSelectedIndex).abs() >= 2 &&
        (previousSelectedIndex + (1 * selectedAlignment.sign)) %
                (childrenCount * 2) !=
            selectedIndex) {
      if (childrenCount % 2 == 0)
        duration =
            Duration(milliseconds: previousDuration.inMilliseconds ~/ 1.75);
      else
        duration =
            Duration(milliseconds: previousDuration.inMilliseconds ~/ 0.75);
    }

    do {
      // Update the opacities, alignments & generate the stack children
      _updateChildrenOpacities();
      _updateChildrenAlignments(alignments[selectedIndex]! > 0 ? -1 : 1);
      _generateStackChildren();
      setState(() {});
      // If the children count is even then delay the animation
      if (childrenCount % 2 == 0) await Future.delayed(duration);
    } while (alignments[selectedIndex]!.toPrecision(1).abs() > 0.1);

    // Reset the duration & call the handler
    widget.handler(selectedIndex % widget.icons.length);
    duration = previousDuration;
  }
}
