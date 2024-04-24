import 'package:flutter/material.dart';

class OvalNavigationBar extends StatelessWidget {
  final Function(int) onDestinationSelected;
  final List<NavigationDestination> destinations;
  final int currentIndex;

  OvalNavigationBar({
    required this.onDestinationSelected,
    required this.currentIndex,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 70,
          selectedIndex: currentIndex,
          onDestinationSelected: (int index) => onDestinationSelected(index),
          destinations: destinations,
        ),
      ),
    );
  }
}
