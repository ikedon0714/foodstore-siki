import 'package:flutter/material.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/core/widgets/app_button.dart';
import 'package:foodstore_siki/pages/stamp/stamp_scan/widgets/corner_marker.dart';

class ScannerFrame extends StatelessWidget {
  const ScannerFrame({
    super.key,
    required this.isScanning,
    required this.onTestScan,
  });

  final bool isScanning;
  final VoidCallback onTestScan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 枠
        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // 説明（枠内）
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 80,
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'QRコードを枠内に収めてください',
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // コーナーマーカー
                const CornerMarkerSet(),
              ],
            ),
          ),
        ),

        // デバッグ用（開発時のみ想定）
        if (isScanning)
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: AppButton(
              label: 'テスト: スキャン成功',
              onPressed: onTestScan,
            ),
          ),
      ],
    );
  }
}
