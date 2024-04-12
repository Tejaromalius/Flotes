import 'package:flotes/core/app.dart';

// import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Dependencies.register();
  // SharedPreferences preferences = Get.find<SharedPreferences>();
  // if (!preferences.containsKey("authenticatedLogin"))
  //   await preferences.setBool("authenticatedLogin", false);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App());
}
