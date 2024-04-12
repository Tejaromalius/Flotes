import 'package:flotes/screens/home.dart';
import 'package:flotes/screens/editor.dart';
import 'package:flotes/screens/search.dart';
import 'package:flotes/screens/splash.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: '/editor',
      page: () => EditorScreen(),
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOutSine,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(
      name: '/search',
      page: () => SearchScreen(),
    ),
  ];
}
