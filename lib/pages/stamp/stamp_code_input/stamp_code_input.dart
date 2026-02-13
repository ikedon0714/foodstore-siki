import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/pages/stamp/stamp_code_input/hooks/use_stamp_code_input.dart';
import 'package:foodstore_siki/pages/stamp/stamp_code_input/widgets/input_form.dart';

class StampCodeInputPage extends HookConsumerWidget {
  const StampCodeInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = useStampCodeInput(context: context, ref: ref);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('認証コード入力'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pin,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '認証コードを入力',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '店舗で提示された\n認証コードを入力してください',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              if (vm.isBlocked)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.error),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber, color: AppColors.error),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '本日の認証回数を超過しました',
                          style: TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              InputForm(
                controller: vm.codeController,
                isBlocked: vm.isBlocked,
                isLoading: vm.isLoading,
                failedAttempts: vm.failedAttempts,
                maxAttempts: vm.maxAttempts,
                onSubmit: vm.submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
