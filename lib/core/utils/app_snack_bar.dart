// New file: lib/core/utils/app_snack_bar.dart

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showError(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.error,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.success,
    );
  }

  static void _show(
      BuildContext context, {
        required String message,
        required Color backgroundColor,
      }) {
    final messenger = ScaffoldMessenger.of(context);

    // 連続呼び出し時に前を消す
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
