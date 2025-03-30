import 'package:arilo_admin/utils/popups/sample_snack.dart';
import 'package:flutter/material.dart';


class ALoaders {
  /// Shows a success snackbar with green styling
  static void showSuccessSnackBar(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _showSnackBar(
      context,
      title: title,
      message: message,
      type: SnackBarType.success,
    );
  }

  /// Shows a failure/error snackbar with red styling
  static void showErrorSnackBar(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _showSnackBar(
      context,
      title: title,
      message: message,
      type: SnackBarType.failure,
    );
  }

  /// Shows a warning snackbar with yellow styling
  static void showWarningSnackBar(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _showSnackBar(
      context,
      title: title,
      message: message,
      type: SnackBarType.warning,
    );
  }

  /// Shows a help/info snackbar with blue styling
  static void showInfoSnackBar(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _showSnackBar(
      context,
      title: title,
      message: message,
      type: SnackBarType.help,
    );
  }

  /// Internal method to display the snackbar
  static void _showSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    required SnackBarType type,
  }) {
    // Hide any existing snackbars
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Show the new snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: CustomSnackBar(
          title: title,
          message: message,
          type: type,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

enum SnackBarType {
  success,
  failure,
  warning,
  help,
}
