import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/theme/app_colors.dart';

/// クーポン一覧画面
class CouponListPage extends ConsumerStatefulWidget {
  const CouponListPage({super.key});

  @override
  ConsumerState<CouponListPage> createState() => _CouponListPageState();
}

class _CouponListPageState extends ConsumerState<CouponListPage> {
  String? _selectedStoreId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('クーポン'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: Column(
        children: [
          // 店舗選択バー
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.white,
            child: Row(
              children: [
                Icon(
                  Icons.store,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedStoreId != null
                        ? 'サンプル店舗' // TODO: 実際の店舗名を取得
                        : '対象店舗を選択',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _showStoreSelectDialog,
                  child: const Text('変更'),
                ),
              ],
            ),
          ),

          // クーポンリスト
          Expanded(
            child: _selectedStoreId != null
                ? _buildCouponList()
                : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  /// クーポンリスト
  Widget _buildCouponList() {
    // TODO: 実際のクーポンデータを取得
    final sampleCoupons = [
      {
        'id': 'coupon1',
        'title': '10%割引クーポン',
        'description': 'お会計から10%割引',
        'expiry': DateTime.now().add(const Duration(days: 7)),
        'imageUrl': null,
      },
      {
        'id': 'coupon2',
        'title': 'ドリンク1杯無料',
        'description': 'お好きなドリンク1杯が無料',
        'expiry': DateTime.now().add(const Duration(days: 14)),
        'imageUrl': null,
      },
      {
        'id': 'coupon3',
        'title': 'デザートサービス',
        'description': '本日のデザートをサービス',
        'expiry': DateTime.now().add(const Duration(days: 3)),
        'imageUrl': null,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sampleCoupons.length,
      itemBuilder: (context, index) {
        final coupon = sampleCoupons[index];
        return _CouponCard(
          id: coupon['id'] as String,
          title: coupon['title'] as String,
          description: coupon['description'] as String,
          expiry: coupon['expiry'] as DateTime,
          imageUrl: coupon['imageUrl'] as String?,
          onTap: () => context.push('/coupon/${coupon['id']}'),
        );
      },
    );
  }

  /// 空の状態
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 80,
            color: AppColors.grey400,
          ),
          const SizedBox(height: 16),
          Text(
            '対象店舗を選択してください',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'クーポンを確認するには\n店舗を選択してください',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _showStoreSelectDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('店舗を選択'),
          ),
        ],
      ),
    );
  }

  /// 店舗選択ダイアログ
  void _showStoreSelectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('店舗を選択'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              // TODO: 実際の店舗リストを取得
              _buildStoreListTile('store1', 'サンプル店舗A'),
              _buildStoreListTile('store2', 'サンプル店舗B'),
              _buildStoreListTile('store3', 'サンプル店舗C'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
        ],
      ),
    );
  }

  /// 店舗リストアイテム
  Widget _buildStoreListTile(String storeId, String storeName) {
    return ListTile(
      title: Text(storeName),
      leading: Icon(
        Icons.store,
        color: AppColors.primary,
      ),
      trailing: _selectedStoreId == storeId
          ? Icon(Icons.check, color: AppColors.primary)
          : null,
      onTap: () {
        setState(() {
          _selectedStoreId = storeId;
        });
        Navigator.pop(context);
      },
    );
  }
}

/// クーポンカード
class _CouponCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final DateTime expiry;
  final String? imageUrl;
  final VoidCallback onTap;

  const _CouponCard({
    required this.id,
    required this.title,
    required this.description,
    required this.expiry,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final daysLeft = expiry.difference(DateTime.now()).inDays;
    final isExpiringSoon = daysLeft <= 3;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // クーポン画像 or アイコン
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  ),
                )
                    : _buildPlaceholder(),
              ),
              const SizedBox(width: 16),

              // クーポン情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: isExpiringSoon
                              ? AppColors.error
                              : AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'あと${daysLeft}日',
                          style: TextStyle(
                            fontSize: 12,
                            color: isExpiringSoon
                                ? AppColors.error
                                : AppColors.textTertiary,
                            fontWeight: isExpiringSoon
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 矢印アイコン
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.grey500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.local_offer,
        size: 40,
        color: AppColors.primary,
      ),
    );
  }
}