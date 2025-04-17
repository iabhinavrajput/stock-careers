import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.green);
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.red);
  }

  static void _showSnackBar(BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        content: Text(message,style: Theme.of(context).textTheme.titleSmall,),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
