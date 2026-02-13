import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/core/utils/app_snack_bar.dart';
import 'package:foodstore_siki/core/widgets/app_button.dart';
import 'package:foodstore_siki/core/widgets/app_confirm_dialog.dart';

/// クーポン詳細画面
class CouponDetailPage extends ConsumerWidget {
  final String couponId;

  const CouponDetailPage({
    super.key,
    required this.couponId, // ★ 必須パラメータ維持
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 実際のクーポンデータを取得
    final coupon = _getSampleCoupon(couponId);

    if (coupon == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('クーポン詳細'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
        ),
        body: const Center(
          child: Text('クーポンが見つかりません'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('クーポン詳細'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    color: AppColors.primary.withOpacity(0.1),
                    child: coupon['imageUrl'] != null
                        ? Image.network(
                      coupon['imageUrl'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                    )
                        : _buildPlaceholder(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coupon['title'] as String,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          icon: Icons.access_time,
                          label: '有効期限',
                          value: _formatDate(coupon['expiry'] as DateTime),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.store,
                          label: '対象店舗',
                          value: coupon['storeName'] as String,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '詳細',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          coupon['description'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '注意事項',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          coupon['terms'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ★ 使用ボタン: AppButton に統一 + AppConfirmDialog.show に統合
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'クーポンを使用する',
                  onPressed: () => _confirmAndUseCoupon(context, coupon),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAndUseCoupon(
      BuildContext context,
      Map<String, dynamic> coupon,
      ) async {
    final ok = await AppConfirmDialog.show(
      context: context,
      title: 'クーポンを使用しますか？',
      message: '「${coupon['title']}」を使用します。\nこの操作は取り消せません。',
      cancelText: 'キャンセル',
      confirmText: '使用する',
    );

    if (ok != true) return;

    await _useCoupon(context, coupon['id'] as String);
  }

  Future<void> _useCoupon(BuildContext context, String couponId) async {
    // TODO: 実際のクーポン使用処理を実装
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;
    AppSnackBar.showSuccess(context, 'クーポンを使用しました');
    context.pop(); // /coupons へ戻す想定（router整合） :contentReference[oaicite:1]{index=1}
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.local_offer,
        size: 80,
        color: AppColors.primary,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日まで';
  }

  Map<String, dynamic>? _getSampleCoupon(String id) {
    final coupons = {
      'coupon1': {
        'id': 'coupon1',
        'title': '10%割引クーポン',
        'description': 'お会計から10%割引いたします。他のクーポンとの併用はできません。',
        'expiry': DateTime.now().add(const Duration(days: 7)),
        'storeName': 'サンプル店舗A',
        'imageUrl': null,
        'terms': '・1回のみ使用可能です\n'
            '・他のクーポンとの併用はできません\n'
            '・一部対象外商品があります\n'
            '・有効期限を過ぎると使用できません',
      },
      'coupon2': {
        'id': 'coupon2',
        'title': 'ドリンク1杯無料',
        'description': 'お好きなドリンク1杯が無料になります。',
        'expiry': DateTime.now().add(const Duration(days: 14)),
        'storeName': 'サンプル店舗B',
        'imageUrl': null,
        'terms': '・1回のみ使用可能です\n'
            '・アルコール飲料は対象外です\n'
            '・テイクアウトでも使用可能です',
      },
      'coupon3': {
        'id': 'coupon3',
        'title': 'デザートサービス',
        'description': '本日のデザートを1品サービスいたします。',
        'expiry': DateTime.now().add(const Duration(days: 3)),
        'storeName': 'サンプル店舗C',
        'imageUrl': null,
        'terms': '・1回のみ使用可能です\n'
            '・在庫状況により提供できない場合があります\n'
            '・ディナータイム限定です',
      },
    };

    return coupons[id];
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
