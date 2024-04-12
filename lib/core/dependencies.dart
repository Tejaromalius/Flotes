import 'package:flotes/services/client.dart' show Client;
import 'package:flotes/common/themes.dart' show CustomThemes;
import 'package:flotes/services/biometric_authentication.dart'
    show BiometricsAuthentication;

import 'package:get/get.dart';
import 'package:logger/logger.dart' show Logger;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class Dependencies {
  static Future<void> register() async {
    _registerLogger();

    await _registerSharedPreferences();
    await _registerThemes();
    await _registerAuthentication();
    await _registerClient();
  }

  static void _registerLogger() => Get.put<Logger>(Logger());

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
    BiometricsAuthentication biometricsAuthentication =
        BiometricsAuthentication();
    await biometricsAuthentication.init();
    Get.put<BiometricsAuthentication>(biometricsAuthentication);
  }

  static Future<void> _registerClient() async {
    Client client = Client();
    await client.setSignInStatus();
    Get.put<Client>(client);
  }
}
