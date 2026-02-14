// lib/pages/store/widgets/store_add_sections.dart
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../store_add_constants.dart';
import 'store_add_parts.dart';

class StoreAddImageSection extends StatelessWidget {
  const StoreAddImageSection({
    super.key,
    required this.image,
    required this.uploadProgress,
    required this.onTap,
  });

  final File? image;
  final double? uploadProgress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StoreAddSectionTitle(title: '店舗画像 *'),
        const SizedBox(height: 12),
        StoreAddImagePicker(
          image: image,
          onTap: onTap,
          uploadProgress: uploadProgress,
        ),
      ],
    );
  }
}

class StoreAddBasicSection extends StatelessWidget {
  const StoreAddBasicSection({
    super.key,
    required this.storeNameController,
    required this.descriptionController,
  });

  final TextEditingController storeNameController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StoreAddSectionTitle(title: '基本情報'),
        const SizedBox(height: 12),
        AppTextField(
          controller: storeNameController,
          labelText: '店舗名 *',
          hintText: '例: Restoran Nasi Kandar',
          prefixIcon: Icons.store,
          validator: (v) => (v == null || v.isEmpty) ? '店舗名を入力してください' : null,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: descriptionController,
          labelText: '説明 *',
          hintText: '店舗の特徴や特色を入力',
          prefixIcon: Icons.description,
          keyboardType: TextInputType.multiline,
          validator: (v) => (v == null || v.isEmpty) ? '説明を入力してください' : null,
        ),
      ],
    );
  }
}

class StoreAddContactSection extends StatelessWidget {
  const StoreAddContactSection({
    super.key,
    required this.tellNumberController,
    required this.validatePhone,
  });

  final TextEditingController tellNumberController;
  final String? Function(String?) validatePhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StoreAddSectionTitle(title: '連絡先情報'),
        const SizedBox(height: 12),
        AppTextField(
          controller: tellNumberController,
          labelText: '電話番号 *',
          hintText: '例: 03-1234 5678 または 012-345 6789',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: validatePhone,
        ),
      ],
    );
  }
}

class StoreAddAddressSection extends StatelessWidget {
  const StoreAddAddressSection({
    super.key,
    required this.postalCodeController,
    required this.addressController,
    required this.selectedState,
    required this.onStateChanged,
    required this.validatePostalCode,
  });

  final TextEditingController postalCodeController;
  final TextEditingController addressController;
  final String? selectedState;
  final ValueChanged<String?> onStateChanged;
  final String? Function(String?) validatePostalCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StoreAddSectionTitle(title: '住所'),
        const SizedBox(height: 12),
        AppTextField(
          controller: postalCodeController,
          labelText: '郵便番号 *',
          hintText: '例: 50450',
          prefixIcon: Icons.local_post_office,
          keyboardType: TextInputType.number,
          validator: validatePostalCode,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedState,
          decoration: AppInputStyles.defaultDecoration(
            labelText: '州 *',
            prefixIcon: Icons.location_city,
          ),
          items: malaysianStates
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: onStateChanged,
          validator: (v) => v == null ? '州を選択してください' : null,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: addressController,
          labelText: '詳細住所 *',
          hintText: '例: Jalan Bukit Bintang',
          prefixIcon: Icons.home,
          validator: (v) => (v == null || v.isEmpty) ? '住所を入力してください' : null,
        ),
      ],
    );
  }
}

class StoreAddBusinessSection extends StatelessWidget {
  const StoreAddBusinessSection({
    super.key,
    required this.openingTime,
    required this.closingTime,
    required this.onPickOpening,
    required this.onPickClosing,
    required this.selectedDays,
    required this.onDaysChanged,
  });

  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final VoidCallback onPickOpening;
  final VoidCallback onPickClosing;
  final List<String> selectedDays;
  final ValueChanged<List<String>> onDaysChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StoreAddSectionTitle(title: '営業情報'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StoreAddTimePickerField(
                label: '開店時刻 *',
                time: openingTime,
                onTap: onPickOpening,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StoreAddTimePickerField(
                label: '閉店時刻 *',
                time: closingTime,
                onTap: onPickClosing,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StoreAddRegularHolidaySelector(
          selectedDays: selectedDays,
          onChanged: onDaysChanged,
        ),
      ],
    );
  }
}

class StoreAddFacilitySection extends StatelessWidget {
  const StoreAddFacilitySection({
    super.key,
    required this.seatsController,
    required this.parkingController,
    required this.selectedPriceRange,
    required this.onPriceChanged,
  });

  final TextEditingController seatsController;
  final TextEditingController parkingController;
  final String? selectedPriceRange;
  final ValueChanged<String?> onPriceChanged;

  String? _validateIntRequired(String? v, String label) {
    if (v == null || v.isEmpty) return '$labelを入力';
    return int.tryParse(v) == null ? '数値で入力' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StoreAddSectionTitle(title: '施設情報'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: seatsController,
                labelText: '座席数 *',
                hintText: '例: 50',
                prefixIcon: Icons.event_seat,
                keyboardType: TextInputType.number,
                validator: (v) => _validateIntRequired(v, '座席数'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTextField(
                controller: parkingController,
                labelText: '駐車場 *',
                hintText: '例: 20',
                prefixIcon: Icons.local_parking,
                keyboardType: TextInputType.number,
                validator: (v) => _validateIntRequired(v, '駐車場台数'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedPriceRange,
          decoration: AppInputStyles.defaultDecoration(
            labelText: '価格帯',
            prefixIcon: Icons.attach_money,
          ),
          items: priceRanges
              .map((range) => DropdownMenuItem(value: range, child: Text(range)))
              .toList(),
          onChanged: onPriceChanged,
        ),
      ],
    );
  }
}

class StoreAddSubmitSection extends StatelessWidget {
  const StoreAddSubmitSection({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoreAddSubmitButton(
          isLoading: isLoading,
          onPressed: onPressed,
        ),
        const SizedBox(height: 16),
        const StoreAddRequiredNote(),
      ],
    );
  }
}
