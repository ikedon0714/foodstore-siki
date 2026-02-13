import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/app_snack_bar.dart';
import '../../../models/users/gender.dart';
import '../../../notifiers/auth_notifier.dart';

/// SetBasicInfoPage 用のロジックをまとめたカスタムフック
///
/// - formKey / controllers / states
/// - pickBirthday
/// - onSave
///
/// UI 側は返却値を並べるだけにする。
UseSetBasicInfoResult useSetBasicInfo({
  required BuildContext context,
  required WidgetRef ref,
}) {
  // FormKey
  final formKey = useMemoized(() => GlobalKey<FormState>());

  // Controllers
  final displayNameController = useTextEditingController();
  final birthdayController = useTextEditingController();

  // State
  final selectedGender = useState<Gender?>(null);
  final selectedBirthday = useState<DateTime?>(null);

  // 誕生日表示文字列の同期（controllerは作り直さず text だけ更新）
  useEffect(() {
    final d = selectedBirthday.value;
    if (d == null) {
      birthdayController.text = '';
    } else {
      birthdayController.text =
      '${d.year.toString().padLeft(4, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.day.toString().padLeft(2, '0')}';
    }
    return null;
  }, [selectedBirthday.value]);

  Future<void> pickBirthday() async {
    final now = DateTime.now();
    final initial = selectedBirthday.value ?? DateTime(now.year - 20, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900, 1, 1),
      lastDate: now,
    );

    if (picked != null) {
      selectedBirthday.value = picked;
    }
  }

  Future<void> onSave() async {
    final currentState = formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    if (selectedGender.value == null) {
      AppSnackBar.showError(context, '性別を選択してください');
      return;
    }
    if (selectedBirthday.value == null) {
      AppSnackBar.showError(context, '誕生日を選択してください');
      return;
    }

    try {
      await ref.read(authNotifierProvider.notifier).setBasicInfo(
        userName: displayNameController.text.trim(),
        gender: selectedGender.value!,
        birthday: selectedBirthday.value!,
      );

      if (!context.mounted) return;
      AppSnackBar.showSuccess(context, '保存しました');
    } catch (e) {
      if (!context.mounted) return;
      AppSnackBar.showError(context, e.toString());
    }
  }

  return UseSetBasicInfoResult(
    formKey: formKey,
    displayNameController: displayNameController,
    birthdayController: birthdayController,
    selectedGender: selectedGender.value,
    selectedBirthday: selectedBirthday.value,
    setGender: (g) => selectedGender.value = g,
    pickBirthday: pickBirthday,
    onSave: onSave,
  );
}

/// useSetBasicInfo の戻り値
class UseSetBasicInfoResult {
  final GlobalKey<FormState> formKey;

  final TextEditingController displayNameController;
  final TextEditingController birthdayController;

  final Gender? selectedGender;
  final DateTime? selectedBirthday;

  final void Function(Gender? gender) setGender;

  final Future<void> Function() pickBirthday;
  final Future<void> Function() onSave;

  const UseSetBasicInfoResult({
    required this.formKey,
    required this.displayNameController,
    required this.birthdayController,
    required this.selectedGender,
    required this.selectedBirthday,
    required this.setGender,
    required this.pickBirthday,
    required this.onSave,
  });
}
