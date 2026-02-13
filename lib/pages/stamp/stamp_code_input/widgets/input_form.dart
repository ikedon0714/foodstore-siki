import 'package:flutter/material.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/core/widgets/app_button.dart';
import 'package:foodstore_siki/core/widgets/app_text_field.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.controller,
    required this.isBlocked,
    required this.isLoading,
    required this.failedAttempts,
    required this.maxAttempts,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool isBlocked;
  final bool isLoading;
  final int failedAttempts;
  final int maxAttempts;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final remaining = (maxAttempts - failedAttempts).clamp(0, maxAttempts);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: controller,
          labelText: '認証コード',
          hintText: '認証コード',
          enabled: !isBlocked && !isLoading,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onSubmit(),
        ),
        const SizedBox(height: 24),
        AppButton(
          label: '認証する',
          isLoading: isLoading,
          enabled: !isBlocked,
          onPressed: () => onSubmit(),
        ),
        const SizedBox(height: 16),
        if (!isBlocked && failedAttempts > 0)
          Text(
            '残り $remaining 回',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
