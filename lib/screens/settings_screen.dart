import 'package:flotes/widgets/widgets.dart' as CustomWidgets;

import 'package:flutter/material.dart';

class SettingsScreen {
  void build(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: Colors.transparent.withOpacity(0.25),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.95,
        minWidth: MediaQuery.of(context).size.width * 0.95,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        minHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
          child: Column(
            children: [
              CustomWidgets.UserInfoContainer(),
              SizedBox(height: 10),
              Divider(thickness: 1),
              Expanded(child: Container()),
              CustomWidgets.AuthenticationSwitchButton(),
              SizedBox(height: 30),
              CustomWidgets.ThemeSwitchButton(),
              SizedBox(height: 30),
              CustomWidgets.GoogleLogoutButton(),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
