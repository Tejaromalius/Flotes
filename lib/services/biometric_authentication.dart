import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences = Get.find<SharedPreferences>();

class BiometricsAuthentication {
  late bool localAuthenticationRequired;
  late final bool _fingerprintSupported;
  late final LocalAuthentication _localAuth;

  Future<void> init() async {
    if (!preferences.containsKey("localAuthenticationRequired")) {
      this.localAuthenticationRequired = false;
      await preferences.setBool("localAuthenticationRequired", false);
    } else {
      this.localAuthenticationRequired =
          preferences.getBool("localAuthenticationRequired")!;
    }
    this._localAuth = LocalAuthentication();
    this._fingerprintSupported = (await _localAuth.getAvailableBiometrics())
        .contains(BiometricType.strong);
  }

  Future<void> toggle() async {
    localAuthenticationRequired = !localAuthenticationRequired;
    await preferences.setBool(
        "localAuthenticationRequired", localAuthenticationRequired);
  }

  Future<void> validate() async {
    if (!this.localAuthenticationRequired || !_fingerprintSupported) return;

    bool biometricsAuthenticated = false;
    while (!biometricsAuthenticated) {
      try {
        biometricsAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Scan your fingerprint to login',
          options: AuthenticationOptions(
            stickyAuth: true,
            sensitiveTransaction: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ),
        );
      } catch (exception) {
        continue;
      }
    }
  }
}
