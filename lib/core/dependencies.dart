import 'package:flotes/common/themes.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dependencies {
  static Future<void> register() async {
    await _registerSharedPreferences();
    await _registerThemes();
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
}
