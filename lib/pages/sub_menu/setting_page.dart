import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/core/utils/app_snack_bar.dart';
import 'package:foodstore_siki/core/widgets/app_button.dart';
import 'package:foodstore_siki/core/widgets/app_confirm_dialog.dart';

/// 設定画面
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 通知設定
    final pushNotification = useState(true);
    final emailNotification = useState(false);
    final couponNotification = useState(true);
    final stampNotification = useState(true);

    // その他設定
    final autoLogin = useState(true);
    final darkMode = useState(false);

    final isSaving = useState(false);

    Future<void> handleSave() async {
      if (isSaving.value) return;

      isSaving.value = true;
      try {
        // TODO: 実際の設定保存処理
        await Future.delayed(const Duration(milliseconds: 500));

        if (!context.mounted) return;
        AppSnackBar.showSuccess(context, '設定を保存しました');
      } catch (e) {
        if (!context.mounted) return;
        AppSnackBar.showError(context, '設定の保存に失敗しました: $e');
      } finally {
        isSaving.value = false;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('設定'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            _buildSection(
              title: '通知設定',
              children: [
                _SettingSwitch(
                  title: 'プッシュ通知',
                  subtitle: 'アプリからの通知を受け取る',
                  value: pushNotification.value,
                  onChanged: (value) => pushNotification.value = value,
                ),
                _SettingSwitch(
                  title: 'メール通知',
                  subtitle: 'お得な情報をメールで受け取る',
                  value: emailNotification.value,
                  onChanged: (value) => emailNotification.value = value,
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '通知の種類',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                _SettingSwitch(
                  title: 'クーポン通知',
                  subtitle: '新しいクーポンが追加されたときに通知',
                  value: couponNotification.value,
                  onChanged: (value) => couponNotification.value = value,
                ),
                _SettingSwitch(
                  title: 'スタンプ通知',
                  subtitle: 'スタンプ関連の通知を受け取る',
                  value: stampNotification.value,
                  onChanged: (value) => stampNotification.value = value,
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: 'アプリ設定',
              children: [
                _SettingSwitch(
                  title: '自動ログイン',
                  subtitle: '次回から自動的にログインする',
                  value: autoLogin.value,
                  onChanged: (value) => autoLogin.value = value,
                ),
                _SettingSwitch(
                  title: 'ダークモード',
                  subtitle: '暗いテーマを使用する（準備中）',
                  value: darkMode.value,
                  onChanged: (value) {
                    // ★ 準備中：ONにさせず戻す
                    if (value) {
                      AppSnackBar.showError(context, 'ダークモードは準備中です');
                      darkMode.value = false;
                      return;
                    }
                    darkMode.value = value;
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: 'データ管理',
              children: [
                _SettingButton(
                  title: 'キャッシュをクリア',
                  subtitle: '一時データを削除',
                  icon: Icons.delete_outline,
                  onTap: () => _confirmClearCache(context),
                ),
                _SettingButton(
                  title: 'データをエクスポート',
                  subtitle: 'ユーザーデータをダウンロード',
                  icon: Icons.download,
                  onTap: () {
                    AppSnackBar.showError(context, 'データエクスポートは準備中です');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildSection(
              title: 'アカウント管理',
              children: [
                _SettingButton(
                  title: 'パスワードを変更',
                  icon: Icons.lock_outline,
                  onTap: () {
                    AppSnackBar.showError(context, 'パスワード変更は準備中です');
                  },
                ),
                _SettingButton(
                  title: 'アカウントを削除',
                  icon: Icons.delete_forever,
                  textColor: AppColors.error,
                  onTap: () => _confirmDeleteAccount(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ★ 保存ボタン（AppButton）
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: '保存する',
                  isLoading: isSaving.value,
                  onPressed: handleSave,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Future<void> _confirmClearCache(BuildContext context) async {
    final ok = await AppConfirmDialog.show(
      context: context,
      title: 'キャッシュをクリア',
      message: 'キャッシュデータを削除しますか？\nこの操作は取り消せません。',
      cancelText: 'キャンセル',
      confirmText: 'クリア',
      confirmTextColor: AppColors.error,
    );
    if (ok != true) return;

    await _clearCache(context);
  }

  Future<void> _clearCache(BuildContext context) async {
    // TODO: 実際のキャッシュクリア処理
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;
    AppSnackBar.showSuccess(context, 'キャッシュをクリアしました');
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final ok = await AppConfirmDialog.show(
      context: context,
      title: 'アカウントを削除',
      message: 'アカウントを削除しますか？\n\nすべてのデータが削除され、\nこの操作は取り消せません。',
      cancelText: 'キャンセル',
      confirmText: '削除する',
      confirmTextColor: AppColors.error,
    );
    if (ok != true) return;

    AppSnackBar.showError(context, 'アカウント削除は準備中です');
  }
}

class _SettingSwitch extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingSwitch({
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle!,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      )
          : null,
      value: value,
      activeColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}

class _SettingButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? textColor;

  const _SettingButton({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle!,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      )
          : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.grey500,
      ),
      onTap: onTap,
    );
  }
}
