import 'dart:async' show Timer;

import 'package:flotes/services/client.dart';
import 'package:flotes/widgets/scaffold/scaffold.dart' show showSnackBar;

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLogoutButton extends StatelessWidget {
  void _onPressed(BuildContext context) async {
    await Get.find<Client>().signOutUser();

    if (!Get.find<Client>().googleUserIsSignedIn) {
      await Get.find<SharedPreferences>().setBool('authenticatedLogin', false);
      Timer(
        const Duration(milliseconds: 250),
        () => Get.offAndToNamed('/splash'),
      );
    } else {
      Navigator.of(context).pop();
      showSnackBar(
        context,
        message: 'Logout failed. Please try again.',
        color: Colors.redAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FloatingActionButton(
        splashColor: Colors.redAccent,
        heroTag: UniqueKey(),
        onPressed: () => _onPressed(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Logout'),
              Expanded(child: Container()),
              Icon(Icons.logout),
            ],
          ),
        ),
      ),
    );
  }
}
