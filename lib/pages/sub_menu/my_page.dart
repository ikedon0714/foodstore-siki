import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/core/utils/app_snack_bar.dart';
import 'package:foodstore_siki/core/widgets/app_button.dart';
import 'package:foodstore_siki/core/widgets/app_text_field.dart';
import 'package:foodstore_siki/models/users/gender.dart';
import 'package:foodstore_siki/notifiers/auth_notifier.dart';

/// マイページ（ユーザー情報編集）
class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    final userNameController = useTextEditingController(
      text: user?.userName ?? '',
    );
    final selectedGender = useState(user?.gender ?? Gender.unknown);
    final selectedBirthday = useState<DateTime?>(
      user?.birthday?.toDate(),
    );
    final isSaving = useState(false);

    Future<void> selectBirthday() async {
      final now = DateTime.now();
      final initialDate =
          selectedBirthday.value ?? DateTime(now.year - 20, now.month, now.day);

      final picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: now,
        locale: const Locale('ja', 'JP'),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: AppColors.white,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        selectedBirthday.value = picked;
      }
    }

    Future<void> handleSave() async {
      if (isSaving.value) return;

      if (userNameController.text.trim().isEmpty) {
        AppSnackBar.showError(context, 'ユーザー名を入力してください');
        return;
      }

      isSaving.value = true;
      try {
        // TODO: 実際のユーザー情報更新処理
        await Future.delayed(const Duration(seconds: 1));

        if (!context.mounted) return;
        AppSnackBar.showSuccess(context, 'プロフィールを更新しました');
        context.pop();
      } catch (e) {
        if (!context.mounted) return;
        AppSnackBar.showError(context, '更新に失敗しました: $e');
      } finally {
        isSaving.value = false;
      }
    }

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('マイページ'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
        ),
        body: const Center(
          child: Text('ユーザー情報が取得できません'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('マイページ'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              color: AppColors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '画像を変更',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '基本情報',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  AppTextField(
                    controller: userNameController,
                    labelText: 'ユーザー名',
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ユーザー名を入力してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  Text(
                    '性別',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grey300),
                    ),
                    child: Column(
                      children: Gender.values.map((gender) {
                        return RadioListTile<Gender>(
                          title: Text(gender.name),
                          value: gender,
                          groupValue: selectedGender.value,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            if (value != null) selectedGender.value = value;
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    '誕生日',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: selectBirthday,
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
                          Icon(Icons.cake_outlined, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              selectedBirthday.value != null
                                  ? '${selectedBirthday.value!.year}年'
                                  '${selectedBirthday.value!.month}月'
                                  '${selectedBirthday.value!.day}日'
                                  : '選択してください',
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedBirthday.value != null
                                    ? AppColors.textPrimary
                                    : AppColors.textTertiary,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.grey500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Text(
                    'お気に入り店舗',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${user.favoriteStore.length}件の店舗をフォロー中',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (user.favoriteStore.isNotEmpty)
                    ...user.favoriteStore.take(3).map((storeId) {
                      return _FavoriteStoreItem(
                        storeName: 'サンプル店舗 $storeId',
                        onUnfollow: () {
                          // TODO: フォロー解除処理
                        },
                      );
                    })
                  else
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'お気に入り店舗がありません',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    ),

                  const SizedBox(height: 32),

                  AppButton(
                    label: '保存する',
                    isLoading: isSaving.value,
                    onPressed: handleSave,
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

class _FavoriteStoreItem extends StatelessWidget {
  final String storeName;
  final VoidCallback onUnfollow;

  const _FavoriteStoreItem({
    required this.storeName,
    required this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Row(
        children: [
          Icon(Icons.store, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              storeName,
              style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
            ),
          ),
          TextButton(
            onPressed: onUnfollow,
            child: const Text('解除'),
          ),
        ],
      ),
    );
  }
}
