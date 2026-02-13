import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/utils/app_snack_bar.dart';

class StampScanViewModel {
  const StampScanViewModel({
    required this.isScanning,
    required this.pickFromGallery,
    required this.onTestScanPressed,
  });

  final bool isScanning;
  final VoidCallback pickFromGallery;
  final VoidCallback onTestScanPressed;
}

StampScanViewModel useStampScan({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final isScanning = useState(true);

  Future<void> addStamp(String qrCode) async {
    // TODO: 実際のスタンプ追加処理
    // - QRコードをバックエンドに送信
    // - スタンプを追加
    // - ポイントを加算
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    AppSnackBar.showSuccess(context, 'スタンプを取得しました！');
    context.pop();
  }

  void handleQRCodeDetected(String code) {
    if (!isScanning.value) return;
    isScanning.value = false;
    addStamp(code);
  }

  void pickFromGallery() {
    AppSnackBar.showError(context, 'ギャラリーからの選択は準備中です');
  }

  void onTestScanPressed() {
    handleQRCodeDetected('test-qr-code-123');
  }

  return StampScanViewModel(
    isScanning: isScanning.value,
    pickFromGallery: pickFromGallery,
    onTestScanPressed: onTestScanPressed,
  );
}
