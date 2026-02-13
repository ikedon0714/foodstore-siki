// lib/pages/store/widgets/store_add_parts.dart
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/app_button.dart';
import 'store_add_sections.dart';

class StoreAddSectionTitle extends StatelessWidget {
  const StoreAddSectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class StoreAddImagePicker extends StatelessWidget {
  const StoreAddImagePicker({
    super.key,
    required this.image,
    required this.onTap,
    required this.uploadProgress,
  });

  final File? image;
  final VoidCallback? onTap;
  final double? uploadProgress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: uploadProgress == null ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey300),
        ),
        child: Stack(
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  image!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 64,
                      color: AppColors.grey400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '画像を選択',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            if (uploadProgress != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.54),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: uploadProgress,
                        color: AppColors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'アップロード中... ${(uploadProgress! * 100).toStringAsFixed(0)}%',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class StoreAddTimePickerField extends StatelessWidget {
  const StoreAddTimePickerField({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay? time;
  final VoidCallback onTap;

  String _hhmm(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final hasTime = time != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey300),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasTime ? _hhmm(time!) : '選択してください',
                    style: TextStyle(
                      fontSize: 16,
                      color: hasTime
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreAddRegularHolidaySelector extends StatelessWidget {
  const StoreAddRegularHolidaySelector({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  final List<String> selectedDays;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '定休日',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: weekDays.map((day) {
              final isSelected = selectedDays.contains(day);
              return FilterChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (selected) {
                  final next = List<String>.from(selectedDays);
                  selected ? next.add(day) : next.remove(day);
                  onChanged(next);
                },
                selectedColor: AppColors.primary.withValues(alpha: 0.2),
                checkmarkColor: AppColors.primary,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class StoreAddSubmitButton extends StatelessWidget {
  const StoreAddSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: '店舗を登録',
      onPressed: () async {
        try {
          await onPressed();
        } catch (e) {
          AppSnackBar.showError(context, 'エラーが発生しました: $e');
        }
      },
      isLoading: isLoading,
    );
  }
}

class StoreAddRequiredNote extends StatelessWidget {
  const StoreAddRequiredNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '* は必須項目です',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: AppColors.textTertiary,
      ),
    );
  }
}
