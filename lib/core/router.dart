import 'package:flotes/screens/index.dart' as Screens;

import 'package:get/get.dart';

class RouteManager {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => Screens.SplashScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => Screens.HomeScreen(),
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/editor',
      page: () => Screens.EditorScreen(),
      transitionDuration: Duration(milliseconds: 250),
    ),
  ];
}
