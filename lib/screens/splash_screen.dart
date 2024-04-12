import 'dart:async';

import 'package:flotes/widgets/index.dart' as CustomWidgets;

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logger logger = Get.find<Logger>();
SharedPreferences preferences = Get.find<SharedPreferences>();

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
    Timer(Duration(seconds: 1), () => setState(() => _loginInProcess = false));
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
