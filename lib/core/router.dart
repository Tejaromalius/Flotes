import 'package:flotes/pages/pages.dart' as Pages;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RouteManager {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => Pages.SplashPage(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(
      name: '/home',
      page: () => Pages.HomePage(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(
      name: '/editor',
      page: () => Pages.EditorPage(),
      transition: Transition.downToUp,
      curve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 250),
    ),
  ];
}
