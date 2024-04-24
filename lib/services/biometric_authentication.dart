import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { waiting, authenticated, failed, canceled }

class BiometricsAuthentication {
  late bool localAuthenticationRequired;
  late final bool fingerprintSupported;
  late final LocalAuthentication _localAuth;

  Future<void> init() async {
    _localAuth = LocalAuthentication();

    localAuthenticationRequired =
        Get.find<SharedPreferences>().getBool("localAuthenticationRequired") ??
            false;

    fingerprintSupported = (await _localAuth.getAvailableBiometrics())
        .contains(BiometricType.strong);
  }

  Future<void> toggle() async {
    if (await _scanFingerprint(cancelable: true) ==
        AuthenticationStatus.authenticated) {
      localAuthenticationRequired = !localAuthenticationRequired;
      await Get.find<SharedPreferences>().setBool(
        "localAuthenticationRequired",
        localAuthenticationRequired,
      );
    }
  }

  Future<void> validate() async {
    if (localAuthenticationRequired) await _scanFingerprint();
  }

  Future<AuthenticationStatus> _scanFingerprint(
      {bool cancelable = false}) async {
    AuthenticationStatus authenticationStatus = AuthenticationStatus.waiting;

    do {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to validate your identity.',
        options: AuthenticationOptions(
          stickyAuth: true,
          sensitiveTransaction: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );

      authenticationStatus = authenticated
          ? AuthenticationStatus.authenticated
          : cancelable
              ? AuthenticationStatus.canceled
              : AuthenticationStatus.failed;
      print(authenticationStatus);
    } while (authenticationStatus != AuthenticationStatus.authenticated &&
        authenticationStatus != AuthenticationStatus.canceled);
    return authenticationStatus;
  }
}
