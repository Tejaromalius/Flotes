import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences = Get.find<SharedPreferences>();

class Authentication {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> init() async {
    if (!preferences.containsKey("authenticatedLogin"))
      await preferences.setBool("authenticatedLogin", false);
  }
}
