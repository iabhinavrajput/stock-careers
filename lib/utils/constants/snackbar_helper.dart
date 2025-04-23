import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.red,
      Duration duration = const Duration(seconds: 2)}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
