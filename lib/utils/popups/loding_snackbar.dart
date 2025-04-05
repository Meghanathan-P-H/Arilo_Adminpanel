import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ALoaders {
  /// Shows a success snackbar with green styling
  static void showSuccessSnackBar({
    required String title,
    required String message,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      type: SnackBarType.success,
    );
  }

  /// Shows an error snackbar with red styling
  static void showErrorSnackBar({
    required String title,
    required String message,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      type: SnackBarType.failure,
    );
  }

  /// Shows a warning snackbar with yellow styling
  static void showWarningSnackBar({
    required String title,
    required String message,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      type: SnackBarType.warning,
    );
  }

  /// Shows an info snackbar with blue styling
  static void showInfoSnackBar({
    required String title,
    required String message,
  }) {
    _showSnackBar(
      title: title,
      message: message,
      type: SnackBarType.help,
    );
  }

  /// Internal method to display the snackbar using GetX
  static void _showSnackBar({
    required String title,
    required String message,
    required SnackBarType type,
  }) {
    Color backgroundColor;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        break;
      case SnackBarType.failure:
        backgroundColor = Colors.red;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        break;
      case SnackBarType.help:
        backgroundColor = Colors.blue;
        break;
    }

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}

enum SnackBarType {
  success,
  failure,
  warning,
  help,
}
