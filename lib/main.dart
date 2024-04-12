import 'package:flotes/core/router.dart';
import 'package:flotes/common/themes.dart';
import 'package:flotes/core/dependencies.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies.register();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
