import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/pages/stamp/stamp_scan/hooks/use_stamp_scan.dart';
import 'package:foodstore_siki/pages/stamp/stamp_scan/widgets/overlay_guide.dart';
import 'package:foodstore_siki/pages/stamp/stamp_scan/widgets/scanner_frame.dart';

class StampScanPage extends HookConsumerWidget {
  const StampScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = useStampScan(context: context, ref: ref);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('QRコードをスキャン'),
        backgroundColor: Colors.black,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: vm.pickFromGallery,
            tooltip: 'ギャラリーから選択',
          ),
        ],
      ),
      body: Stack(
        children: [
          // スキャナ領域（スタブ）
          Center(
            child: ScannerFrame(
              isScanning: vm.isScanning,
              onTestScan: vm.onTestScanPressed,
            ),
          ),

          // 上部説明
          const Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: OverlayGuide(),
          ),
        ],
      ),
    );
  }
}
