import 'package:flutter/material.dart';

void showSnackBarError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
