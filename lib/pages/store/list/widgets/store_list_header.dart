// lib/pages/store/widgets/store_list_header.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';



class StoreListHeader extends HookConsumerWidget {
  final int filtered;
  final int total;
  final VoidCallback onReset;

  const StoreListHeader({
    super.key,
    required this.filtered,
    required this.total,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFiltered = filtered != total;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.grey100,
      child: Row(
        children: [
          Icon(Icons.store, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            '$filtered件の店舗',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (isFiltered) ...[
            Text(
              ' / 全$total件',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Text(
                'フィルタ適用中',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.clear, size: 16),
              label: const Text('解除'),
              onPressed: onReset,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ] else
            const Spacer(),
        ],
      ),
    );
  }
}
