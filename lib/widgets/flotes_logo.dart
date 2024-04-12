import './custom_boxshadow.dart' show CustomBoxShadow;

import 'package:flutter/material.dart';

class FlotesLogo extends StatelessWidget {
  final bool _loginInProcess;
  const FlotesLogo(this._loginInProcess, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      alignment: _loginInProcess ? Alignment(0, 0) : Alignment(0, -0.65),
      child: AnimatedScale(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        scale: _loginInProcess ? 0.5 : 1,
        child: CustomBoxShadow(
          Image.asset(
            "assets/images/logo_flotes_512.png",
            height: 250,
            width: 250,
            filterQuality: FilterQuality.high,
            isAntiAlias: true,
          ),
        ),
      ),
    );
  }
}
