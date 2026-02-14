// lib/pages/store/store_add_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodstore_siki/pages/store/add/widgets/store_add_sections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../notifiers/store_notifier.dart';
import 'hooks/malaysian_formatter.dart';
import 'hooks/store_add_view_model.dart';


class StoreAddPage extends HookConsumerWidget {
  const StoreAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final storeNameController = useTextEditingController();
    final tellNumberController = useTextEditingController();
    final addressController = useTextEditingController();
    final postalCodeController = useTextEditingController();
    final seatsController = useTextEditingController();
    final parkingController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final selectedState = useState<String?>(null);
    final selectedPriceRange = useState<String?>(null);
    final selectedRegularHolidays = useState<List<String>>([]);
    final openingTime = useState<TimeOfDay?>(null);
    final closingTime = useState<TimeOfDay?>(null);

    final vm = ref.watch(storeAddViewModelProvider.notifier);
    final state = ref.watch(storeAddViewModelProvider);

    Future<void> selectTime(bool isOpening) async {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textOnPrimary,
            ),
          ),
          child: child!,
        ),
      );
      if (picked == null) return;

      if (isOpening) {
        openingTime.value = picked;
      } else {
        closingTime.value = picked;
      }
    }

    void showImagePickerMenu() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('ギャラリーから選択'),
                onTap: () {
                  Navigator.pop(context);
                  vm.pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('カメラで撮影'),
                onTap: () {
                  Navigator.pop(context);
                  vm.takePhoto();
                },
              ),
              if (state.selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('画像を削除'),
                  onTap: () {
                    Navigator.pop(context);
                    vm.clearImage();
                  },
                ),
            ],
          ),
        ),
      );
    }

    Future<void> handleSubmit() async {
      if (!formKey.currentState!.validate()) {
        AppSnackBar.showError(context, 'すべての必須項目を入力してください');
        return;
      }
      if (state.selectedImage == null) {
        AppSnackBar.showError(context, '店舗画像を選択してください');
        return;
      }
      if (openingTime.value == null || closingTime.value == null) {
        AppSnackBar.showError(context, '営業時間を設定してください');
        return;
      }
      if (selectedState.value == null) {
        AppSnackBar.showError(context, '州を選択してください');
        return;
      }

      final formattedPhone = vm.formatPhoneForStore(tellNumberController.text);

      final openingHours = vm.formatOpeningHours(
        opening: _TimeOfDayAdapter(openingTime.value!),
        closing: _TimeOfDayAdapter(closingTime.value!),
      );

      final fullAddress = vm.buildFullAddress(
        postalCode: postalCodeController.text,
        state: selectedState.value!,
        addressLine: addressController.text,
      );

      final success = await vm.createStore(
        storeName: storeNameController.text.trim(),
        tellNumber: formattedPhone,
        address: fullAddress,
        openingHours: openingHours,
        regularHoliday: selectedRegularHolidays.value,
        seats: int.parse(seatsController.text),
        parking: int.parse(parkingController.text),
        price: selectedPriceRange.value,
        description: descriptionController.text.trim(),
      );

      if (!context.mounted) return;

      if (success) {
        ref.invalidate(storeNotifierProvider);
        AppSnackBar.showSuccess(context, '店舗を登録しました');
        Navigator.of(context).pop();
        return;
      }

      if (state.errorMessage != null) {
        AppSnackBar.showError(context, state.errorMessage!);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('店舗を追加'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StoreAddImageSection(
                image: state.selectedImage,
                uploadProgress: state.uploadProgress,
                onTap: state.isLoading ? null : showImagePickerMenu,
              ),
              const SizedBox(height: 32),

              StoreAddBasicSection(
                storeNameController: storeNameController,
                descriptionController: descriptionController,
              ),
              const SizedBox(height: 32),

              StoreAddContactSection(
                tellNumberController: tellNumberController,
                validatePhone: vm.validatePhone,
              ),
              const SizedBox(height: 32),

              StoreAddAddressSection(
                postalCodeController: postalCodeController,
                addressController: addressController,
                selectedState: selectedState.value,
                onStateChanged: (v) => selectedState.value = v,
                validatePostalCode: vm.validatePostalCode,
              ),
              const SizedBox(height: 32),

              StoreAddBusinessSection(
                openingTime: openingTime.value,
                closingTime: closingTime.value,
                onPickOpening: () => selectTime(true),
                onPickClosing: () => selectTime(false),
                selectedDays: selectedRegularHolidays.value,
                onDaysChanged: (days) => selectedRegularHolidays.value = days,
              ),
              const SizedBox(height: 32),

              StoreAddFacilitySection(
                seatsController: seatsController,
                parkingController: parkingController,
                selectedPriceRange: selectedPriceRange.value,
                onPriceChanged: (v) => selectedPriceRange.value = v,
              ),
              const SizedBox(height: 32),

              StoreAddSubmitSection(
                isLoading: state.isLoading,
                onPressed: handleSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// VM 側の TimeOfDayLike に渡すためのアダプタ（UI依存はPageに閉じる）
class _TimeOfDayAdapter implements TimeOfDayLike {
  _TimeOfDayAdapter(this._t);
  final TimeOfDay _t;

  @override
  int get hour => _t.hour;

  @override
  int get minute => _t.minute;
}
