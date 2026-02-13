import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/gender_selector.dart';
import '../../notifiers/auth_notifier.dart';
import 'hooks/use_set_basic_info.dart';

class SetBasicInfoPage extends HookConsumerWidget {
  const SetBasicInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    // ★ここを新規追加：ロジックはフックへ集約
    final vm = useSetBasicInfo(context: context, ref: ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('基本情報の設定'),
      ),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    err.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: '再試行',
                    onPressed: () => ref.invalidate(authNotifierProvider),
                  ),
                ],
              ),
            ),
          );
        },
        data: (_) {
          return SafeArea(
            child: Form(
              key: vm.formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  AppTextField(
                    controller: vm.displayNameController,
                    labelText: '表示名',
                    validator: (v) {
                      final value = (v ?? '').trim();
                      if (value.isEmpty) return '表示名を入力してください';
                      if (value.length > 30) return '30文字以内で入力してください';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    '性別',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // ★ここを修正：共通ウィジェット化
                  GenderSelector(
                    selectedGender: vm.selectedGender,
                    onChanged: (g) => vm.setGender(g),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    '誕生日',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  InkWell(
                    onTap: vm.pickBirthday,
                    borderRadius: BorderRadius.circular(12),
                    child: IgnorePointer(
                      child: AppTextField(
                        controller: vm.birthdayController,
                        labelText: 'YYYY-MM-DD',
                        validator: (_) {
                          if (vm.selectedBirthday == null) return '誕生日を選択してください';
                          return null;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  AppButton(
                    label: '保存して続行',
                    onPressed: vm.onSave,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
