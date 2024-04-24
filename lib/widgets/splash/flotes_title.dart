import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlotesTitle extends StatelessWidget {
  final bool _loginInProcess;
  const FlotesTitle(this._loginInProcess, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      alignment: _loginInProcess ? Alignment(0, 0) : Alignment(0, -0.15),
      child: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _loginInProcess ? 0 : 1,
        curve: Curves.easeInQuad,
        child: Text(
          "FLOTES",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Get.theme.primaryTextTheme.bodyLarge!.backgroundColor,
            letterSpacing: 10,
            shadows: <Shadow>[
              Shadow(
                color: Color.fromRGBO(0, 0, 0, 0.125),
                offset: Offset(0, 3),
                blurRadius: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
