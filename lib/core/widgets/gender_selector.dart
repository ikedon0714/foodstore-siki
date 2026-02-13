import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../models/users/gender.dart';

/// 性別選択の共通ウィジェット
///
/// - 今後のプロフィール編集などで再利用する想定
/// - selectedGender / onChanged を外から受け取る
class GenderSelector extends StatelessWidget {
  final Gender? selectedGender;
  final ValueChanged<Gender> onChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        _chip(label: '男性', value: Gender.male),
        _chip(label: '女性', value: Gender.female),
        _chip(label: 'その他', value: Gender.other),
      ],
    );
  }

  Widget _chip({
    required String label,
    required Gender value,
  }) {
    final isSelected = selectedGender == value;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.primary.withOpacity(0.15),
      onSelected: (_) => onChanged(value),
    );
  }
}
