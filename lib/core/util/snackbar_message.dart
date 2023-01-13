import 'package:flutter/material.dart';

class SnackBarMessage {
  void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    _showSnackBar(
      message: message,
      backgroundColor: Colors.green,
      context: context,
    );
  }

  void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    _showSnackBar(
      message: message,
      backgroundColor: Colors.red,
      context: context,
    );
  }

  void _showSnackBar({
    required String message,
    required Color backgroundColor,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
