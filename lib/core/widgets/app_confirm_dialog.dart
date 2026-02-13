import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppConfirmDialog {
  const AppConfirmDialog._();

  /// 汎用の確認ダイアログ
  ///
  /// return: true=OK, false/ null=キャンセル
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String cancelText = 'キャンセル',
    String confirmText = 'OK',
    Color? confirmTextColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelText,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(color: confirmTextColor ?? AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
