import 'package:flutter/material.dart';
import '../../../../models/stores/store_model.dart';

class StoreDetailTable extends StatelessWidget {
  final StoreModel store;

  const StoreDetailTable({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final regularHolidayText =
    store.regularHoliday.isEmpty ? '未設定' : store.regularHoliday.join(', ');

    final priceText = (store.price == null || store.price!.isEmpty)
        ? '未設定'
        : store.price!;

    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          InfoRow(
            icon: Icons.location_on,
            label: '住所',
            value: store.address,
          ),
          const Divider(height: 1),
          InfoRow(
            icon: Icons.phone,
            label: '電話番号',
            value: store.tellNumber, // ★ここを修正（phoneNumber → tellNumber）
          ),
          const Divider(height: 1),
          InfoRow(
            icon: Icons.access_time,
            label: '営業時間',
            value: store.openingHours, // ★ここを修正（ロジック削除して直参照）
          ),
          const Divider(height: 1),
          InfoRow(
            icon: Icons.event_busy,
            label: '定休日',
            value: regularHolidayText, // ★ここを修正（List<String> join）
          ),
          const Divider(height: 1),
          InfoRow(
            icon: Icons.event_seat,
            label: '座席数',
            value: '${store.seats}席', // ★ここを修正（required int）
          ),
          const Divider(height: 1),
          InfoRow(
            icon: Icons.local_parking,
            label: '駐車場',
            value: '${store.parking}', // ★ここを修正（required int）
          ),
          const Divider(height: 1),
          InfoRow(
            icon: Icons.payments,
            label: '目安料金',
            value: priceText, // ★ここを修正（priceRange → price）
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary, // ★ここを修正（Colors.red等を排除）
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
