import 'package:flotes/services/biometric_authentication.dart'
    show BiometricsAuthentication;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationSwitchButton extends StatefulWidget {
  @override
  _AuthenticationSwitchButtonState createState() =>
      _AuthenticationSwitchButtonState();
}

class _AuthenticationSwitchButtonState
    extends State<AuthenticationSwitchButton> {
  late bool localAuthenticationRequired;

  @override
  void initState() {
    super.initState();
    localAuthenticationRequired =
        Get.find<BiometricsAuthentication>().localAuthenticationRequired;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: () async {
          await Get.find<BiometricsAuthentication>().toggle();
          if (localAuthenticationRequired !=
              Get.find<BiometricsAuthentication>().localAuthenticationRequired)
            setState(() => localAuthenticationRequired =
                Get.find<BiometricsAuthentication>()
                    .localAuthenticationRequired);
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedAlign(
              duration: Duration(seconds: 1),
              alignment: localAuthenticationRequired
                  ? Alignment(0.7, 0)
                  : Alignment(-0.7, 0),
              child: AnimatedCrossFade(
                crossFadeState: localAuthenticationRequired
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(seconds: 1),
                firstChild: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: localAuthenticationRequired ? 1 : 0,
                  child: Text('Locked'),
                ),
                secondChild: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: localAuthenticationRequired ? 0 : 1,
                  child: Text('Unlocked'),
                ),
              ),
            ),
            AnimatedAlign(
              duration: Duration(seconds: 1),
              alignment: localAuthenticationRequired
                  ? Alignment(-0.75, 0)
                  : Alignment(0.75, 0),
              child: AnimatedCrossFade(
                duration: Duration(seconds: 1),
                crossFadeState: localAuthenticationRequired
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: AnimatedOpacity(
                    curve: Curves.easeOutExpo,
                    duration: Duration(seconds: 1),
                    opacity: localAuthenticationRequired ? 1 : 0,
                    child: Icon(Icons.lock_outline)),
                secondChild: AnimatedOpacity(
                    curve: Curves.easeOutExpo,
                    duration: Duration(seconds: 1),
                    opacity: localAuthenticationRequired ? 0 : 1,
                    child: Icon(Icons.lock_open)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
