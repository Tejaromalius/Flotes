import 'package:flotes/core/router.dart' show RouteManager;
import 'package:flotes/common/themes.dart' show CustomThemes;
import 'package:flotes/core/dependencies.dart' show Dependencies;

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences = Get.find<SharedPreferences>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies.register();
  await setSystemUIOverlayStyle();
  runApp(App());
}

class App extends StatelessWidget {
  final CustomThemes customThemes = Get.find<CustomThemes>();
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: false,
      initialRoute: '/splash',
      getPages: RouteManager.routes,
      theme: customThemes.lightThemeData,
      darkTheme: customThemes.darkThemeData,
      themeMode: customThemes.currentThemeMode,
      debugShowCheckedModeBanner: false,
      title: 'Flotes',
    );
  }
}

Future<void> setSystemUIOverlayStyle() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}
