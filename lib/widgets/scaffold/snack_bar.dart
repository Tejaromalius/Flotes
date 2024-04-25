import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      width: MediaQuery.of(context).size.width * 0.8,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: color,
      content: Center(child: Text(message)),
      duration: Duration(seconds: 3),
    ),
  );
}
