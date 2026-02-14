import 'package:flutter/material.dart';
import 'package:foodstore_siki/pages/store/detail/widgets/store_detail_header.dart';
import 'package:foodstore_siki/pages/store/detail/widgets/store_detail_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/stores/store_model.dart';
import 'hooks/use_store_detail.dart';


/// 店舗詳細ページ（責務：レイアウト統括のみ）
class StoreDetailPage extends HookConsumerWidget {
  final StoreModel store;

  const StoreDetailPage({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = useStoreDetail(context: context, ref: ref);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('店舗情報'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreDetailHeader(
              store: store,
              isFollowing: vm.isFollowing,
              onToggleFollow: vm.toggleFollow,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StoreBasicInfo(store: store),
            ),
            const SizedBox(height: 24),
            StoreDetailTable(store: store),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _StoreBasicInfo extends StatelessWidget {
  final StoreModel store;

  const _StoreBasicInfo({required this.store});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          store.storeName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          store.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
