import 'package:get/get.dart';

import 'package:flotes/widgets/buttons/buttons.dart' as FlotesButtons;

import 'package:flutter/material.dart';

class GoogleLoginContainer extends StatelessWidget {
  final bool _loading;

  const GoogleLoginContainer(this._loading, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      alignment: _loading ? Alignment(0, 2) : Alignment(0, 1.25),
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Get.theme.primaryColor.withAlpha(150),
        ),
        child: Container(
          alignment: Alignment(0, -0.45),
          // Display the Google login button if the container is about to be displayed
          child: !_loading ? FlotesButtons.GoogleLoginButton() : null,
        ),
      ),
    );
  }
}
