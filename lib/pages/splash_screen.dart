import 'dart:async';

import 'package:flotes/services/client.dart' show Client;
import 'package:flotes/widgets/index.dart' as CustomWidgets;
import 'package:flotes/services/biometric_authentication.dart'
    show BiometricsAuthentication;

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Client client = Get.find<Client>();
final Logger logger = Get.find<Logger>();
final SharedPreferences preferences = Get.find<SharedPreferences>();
final BiometricsAuthentication biometricsAuthentication =
    Get.find<BiometricsAuthentication>();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  bool _loginInProcess = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () async {
      if (client.googleUserIsSignedIn) {
        try {
          await client.signInUser();
          await biometricsAuthentication.validate();
          Get.offNamed('/home');
        } catch (exception) {
          print(exception);
          setState(() => _loginInProcess = false);
        }
      } else {
        setState(() => _loginInProcess = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomWidgets.DoodleBackground(),
          CustomWidgets.FlotesLogo(_loginInProcess),
          CustomWidgets.FlotesTitle(_loginInProcess),
          CustomWidgets.GoogleLoginButtonWithContainer(_loginInProcess),
        ],
      ),
    );
  }
}
