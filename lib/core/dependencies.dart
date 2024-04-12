import 'package:flotes/common/themes.dart' show CustomThemes;
import 'package:flotes/core/authentication.dart' show Authentication;

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class Dependencies {
  static Future<void> register() async {
    await _registerSharedPreferences();
    await _registerThemes();
    await _registerAuthentication();
  }

  static Future<void> _registerSharedPreferences() async {
    SharedPreferences database = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(database);
  }

  static Future<void> _registerThemes() async {
    CustomThemes themes = CustomThemes();
    await themes.init();
    Get.put<CustomThemes>(themes);
  }

  static Future<void> _registerAuthentication() async {
    Authentication auth = Authentication();
    await auth.init();
    Get.put<Authentication>(Authentication());
  }
}
