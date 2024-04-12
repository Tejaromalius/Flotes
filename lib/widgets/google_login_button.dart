import 'dart:async';

import 'package:flotes/services/client.dart' show Client;

import 'package:get/get.dart';
import 'package:flutter/material.dart';

final Client client = Get.find<Client>();

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  double _logoRotationAngle = 0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => setState(() => _logoRotationAngle = 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 275,
      child: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: () async {
          try {
            await client.signInUser();
            Get.offNamed('/home');
          } catch (exception) {
            setState(
                () => _logoRotationAngle = _logoRotationAngle == 0 ? 1 : 0);
          }
        },
        backgroundColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              turns: _logoRotationAngle,
              child: Image.asset(
                'assets/images/logo_google_512.png',
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
