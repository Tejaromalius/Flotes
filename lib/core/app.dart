import 'package:flotes/core/router.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      initialRoute: '/splash',
      getPages: RouteManager.routes,
      // theme: Get.find<ThemeData>(tag: 'light'),
      // darkTheme: Get.find<ThemeData>(tag: 'dark'),
      // themeMode: Get.find<AppThemes>().currentThemeMode,
      debugShowCheckedModeBanner: false,
      title: 'Flotes',
    );
  }
}
