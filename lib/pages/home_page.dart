import 'package:flotes/screens/screens.dart' as Screens;
import 'package:flotes/widgets/widgets.dart' as CustomWidgets;
import 'package:flotes/widgets/physics/physics.dart' as FlotesPhysics;
import 'package:flutter/gestures.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<Widget> homeScreens = const [
    Screens.NotesScreen(),
    Screens.SearchScreen(),
  ];

  final List<NavigationDestination> homeScreenNavigationDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.notes),
      label: 'Notes',
    ),
    NavigationDestination(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
  ];

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.HomeAppBar(),
      body: PageView(
        children: widget.homeScreens,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: FlotesPhysics.PageViewScrollPhysics(),
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.start,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: CustomWidgets.LongPressableFloatingActionButton(
        onLongPressed: Screens.SettingsScreen().build,
        onPressed: () => Get.toNamed('/editor'),
      ),
      bottomNavigationBar: CustomWidgets.OvalNavigationBar(
        onDestinationSelected: _onDestinationSelected,
        currentIndex: _currentIndex,
        destinations: widget.homeScreenNavigationDestinations,
      ),
    );
  }

  void _onDestinationSelected(int index) => setState(() {
        _currentIndex = index;
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        );
      });

  void _onPageChanged(int index) => setState(() => _currentIndex = index);
}
