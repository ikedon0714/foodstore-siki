import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/utils/app_snack_bar.dart';
import 'package:foodstore_siki/notifiers/stamp_auth_notifier.dart';

class StampCodeInputViewModel {
  StampCodeInputViewModel({
    required this.codeController,
    required this.isLoading,
    required this.isBlocked,
    required this.failedAttempts,
    required this.maxAttempts,
    required this.submit,
  });

  final TextEditingController codeController;
  final bool isLoading;
  final bool isBlocked;
  final int failedAttempts;
  final int maxAttempts;
  final Future<void> Function() submit;
}

StampCodeInputViewModel useStampCodeInput({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final codeController = useTextEditingController();

  final authAsync = ref.watch(stampAuthNotifierProvider);
  final authState = authAsync.valueOrNull;

  final isLoading = authState?.isLoading ?? false;
  final isBlocked = authState?.isBlocked ?? false;
  final failedAttempts = authState?.failedAttempts ?? 0;
  const maxAttempts = 3;

  Future<void> submit() async {
    final notifier = ref.read(stampAuthNotifierProvider.notifier);
    final result = await notifier.verifyCode(codeController.text);

    if (!context.mounted) return;

    switch (result) {
      case StampAuthSuccess():
        AppSnackBar.showSuccess(context, 'スタンプを取得しました！');
        // TODO: 実際のスタンプ付与処理（別Notifier/UseCaseへ）
        Navigator.of(context).maybePop();
        break;

      case StampAuthBlocked(:final message):
        AppSnackBar.showError(context, message);
        codeController.clear();
        break;

      case StampAuthFailure(:final message):
        AppSnackBar.showError(context, message);
        codeController.clear();
        break;
    }
  }

  // 初期ロード失敗時の扱い（UIはページ側でメッセージを出したいならここでlisten化も可）
  if (authAsync.hasError) {
    // ここでは黙って UI 側で error 表示したい場合もあるので何もしない
  }

  return StampCodeInputViewModel(
    codeController: codeController,
    isLoading: isLoading,
    isBlocked: isBlocked,
    failedAttempts: failedAttempts,
    maxAttempts: maxAttempts,
    submit: submit,
  );
}
