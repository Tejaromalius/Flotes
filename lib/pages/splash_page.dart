import 'dart:async';

import 'package:flotes/services/client.dart' show Client;
import 'package:flotes/widgets/widgets.dart' as FlotesWidgets;
import 'package:flotes/services/biometric_authentication.dart'
    show BiometricsAuthentication;

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _loginInProcess = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () async {
      if (Get.find<Client>().googleUserIsSignedIn) {
        try {
          await Get.find<Client>().signInUser();
          await Get.find<BiometricsAuthentication>().validate();
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
          FlotesWidgets.DoodleBackground(),
          FlotesWidgets.FlotesLogo(_loginInProcess),
          FlotesWidgets.FlotesTitle(_loginInProcess),
          FlotesWidgets.GoogleLoginContainer(_loginInProcess),
        ],
      ),
    );
  }
}
