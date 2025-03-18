import 'package:flutter/material.dart';

class CustomSnackbars {
  final BuildContext context;

  CustomSnackbars(this.context);

  void error(String message, {String? content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        showCloseIcon: true,
        content: Text(message),
        closeIconColor: Colors.white,
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void success(String message, {String? content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.withValues(alpha: .8),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void warning(String message, {String? content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(message),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
