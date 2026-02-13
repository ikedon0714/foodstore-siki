import 'package:flutter/material.dart';

import 'package:foodstore_siki/core/widgets/app_button.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.onTapScan,
    required this.onTapCodeInput,
  });

  final VoidCallback onTapScan;
  final VoidCallback onTapCodeInput;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          label: 'QRコードでスタンプを取得',
          icon: Icons.qr_code_scanner,
          onPressed: onTapScan,
        ),
        const SizedBox(height: 12),
        AppButton(
          label: '認証コードを入力',
          icon: Icons.pin,
          onPressed: onTapCodeInput,
          isOutlined: false,
        ),
      ],
    );
  }
}
