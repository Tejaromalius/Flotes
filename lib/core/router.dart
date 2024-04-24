import 'package:flotes/pages/pages.dart' as Pages;

import 'package:get/get.dart';

class RouteManager {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => Pages.SplashPage(),
    ),
    GetPage(
      name: '/home',
      page: () => Pages.HomePage(),
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/editor',
      page: () => Pages.EditorPage(),
      transitionDuration: Duration(milliseconds: 250),
    ),
  ];
}
