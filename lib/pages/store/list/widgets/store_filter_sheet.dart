// lib/pages/store/widgets/store_filter_sheet.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../notifiers/store_notifier.dart';


class StoreFilterSheet extends HookConsumerWidget {
  const StoreFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(storeFilterProvider);

    void close() => Navigator.of(context).pop();

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'フィルタ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: close,
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              'ソート',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            _ActionTile(
              icon: Icons.sort_by_alpha,
              title: '店舗名順',
              onTap: () {
                ref.read(storeNotifierProvider.notifier).sortByName();
                close();
              },
            ),
            _ActionTile(
              icon: Icons.event_seat,
              title: '座席数が多い順',
              onTap: () {
                ref.read(storeNotifierProvider.notifier).sortBySeats();
                close();
              },
            ),

            const Divider(height: 28),

            Text(
              '絞り込み',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('駐車場あり'),
              value: filter.onlyWithParking,
              activeColor: AppColors.primary,
              onChanged: (v) {
                // filterStoresWithParking() -> setOnlyWithParking(true/false)
                ref.read(storeNotifierProvider.notifier).setOnlyWithParking(v);
              },
            ),

            const SizedBox(height: 8),

            _PriceSelector(
              value: filter.priceRange,
              onChanged: (v) {
                ref.read(storeNotifierProvider.notifier).setPriceRange(v);
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(storeNotifierProvider.notifier).resetFilters();
                      close();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: BorderSide(color: AppColors.grey300),
                    ),
                    child: const Text('リセット'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: close,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                    ),
                    child: const Text('閉じる'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: onTap,
    );
  }
}

/// 価格帯選択（必要に応じて差し替え）
class _PriceSelector extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const _PriceSelector({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = <String?>[
      null,
      '¥',
      '¥¥',
      '¥¥¥',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '価格帯',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) {
            final selected = opt == value;
            final label = opt ?? '指定なし';

            return ChoiceChip(
              label: Text(label),
              selected: selected,
              selectedColor: AppColors.primary.withValues(alpha: 0.15),
              labelStyle: TextStyle(
                color: selected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => onChanged(opt),
            );
          }).toList(),
        ),
      ],
    );
  }
}
