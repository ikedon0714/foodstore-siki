import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../notifiers/auth_notifier.dart';

/// サブメニュー画面
class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('メニュー'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ユーザー情報カード
            Container(
              width: double.infinity,
              color: AppColors.white,
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // プロフィールアイコン
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // ユーザー情報
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.userName ?? 'ゲストユーザー',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.userRank.name ?? 'レギュラー',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 編集ボタン
                  IconButton(
                    onPressed: () => context.push('/menu/my-page'),
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 新着情報セクション
            _buildSection(
              context,
              title: '新着情報',
              items: [
                _MenuItem(
                  icon: Icons.campaign,
                  title: 'お知らせ',
                  subtitle: '2件の新着があります',
                  onTap: () {
                    // TODO: お知らせ画面へ遷移
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // アカウントセクション
            _buildSection(
              context,
              title: 'アカウント',
              items: [
                _MenuItem(
                  icon: Icons.person,
                  title: 'マイページ',
                  onTap: () => context.push('/menu/my-page'),
                ),
                _MenuItem(
                  icon: Icons.favorite,
                  title: 'お気に入り店舗',
                  subtitle: '${user?.favoriteStore.length ?? 0}件',
                  onTap: () {
                    // TODO: お気に入り店舗画面へ遷移
                  },
                ),
                _MenuItem(
                  icon: Icons.history,
                  title: '利用履歴',
                  onTap: () {
                    // TODO: 利用履歴画面へ遷移
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 設定セクション
            _buildSection(
              context,
              title: '設定',
              items: [
                _MenuItem(
                  icon: Icons.settings,
                  title: '設定',
                  onTap: () => context.push('/menu/settings'),
                ),
                _MenuItem(
                  icon: Icons.help_outline,
                  title: 'ヘルプ',
                  onTap: () {
                    // TODO: ヘルプ画面へ遷移
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // その他セクション
            _buildSection(
              context,
              title: 'その他',
              items: [
                _MenuItem(
                  icon: Icons.description,
                  title: '利用規約',
                  onTap: () {
                    _showTermsDialog(context);
                  },
                ),
                _MenuItem(
                  icon: Icons.privacy_tip,
                  title: 'プライバシーポリシー',
                  onTap: () {
                    _showPrivacyPolicyDialog(context);
                  },
                ),
                _MenuItem(
                  icon: Icons.info_outline,
                  title: 'アプリについて',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ログアウトボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _handleLogout(context, ref),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ログアウト',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// セクション
  Widget _buildSection(
      BuildContext context, {
        required String title,
        required List<_MenuItem> items,
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
          ...items,
        ],
      ),
    );
  }

  /// ログアウト処理
  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ログアウト'),
        content: const Text('ログアウトしますか？'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'ログアウト',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.signOut();
    }
  }

  /// 利用規約ダイアログ
  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('利用規約'),
        content: const SingleChildScrollView(
          child: Text(
            '【利用規約】\n\n'
                '第1条（適用）\n'
                '本規約は、本サービスの利用に関する条件を定めるものです。\n\n'
                '第2条（利用登録）\n'
                'ユーザーは、本規約に同意の上、利用登録を行うものとします。\n\n'
                '第3条（禁止事項）\n'
                'ユーザーは、以下の行為をしてはなりません。\n'
                '・法令または公序良俗に違反する行為\n'
                '・犯罪行為に関連する行為\n'
                '・本サービスの運営を妨害する行為\n\n'
                '詳細は公式サイトをご確認ください。',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  /// プライバシーポリシーダイアログ
  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('プライバシーポリシー'),
        content: const SingleChildScrollView(
          child: Text(
            '【プライバシーポリシー】\n\n'
                '当社は、お客様の個人情報の保護に最大限の注意を払います。\n\n'
                '1. 収集する情報\n'
                '・氏名、メールアドレス\n'
                '・利用履歴、スタンプ情報\n\n'
                '2. 利用目的\n'
                '・サービスの提供\n'
                '・お知らせの配信\n\n'
                '3. 第三者提供\n'
                'お客様の同意なく第三者に提供することはありません。\n\n'
                '詳細は公式サイトをご確認ください。',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  /// アプリについてダイアログ
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SIKI について'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'バージョン: 1.0.0\n\n'
                  'SIKI は店舗スタンプ＆クーポンアプリです。\n\n'
                  'お気に入りの店舗でスタンプを集めて、\n'
                  'お得なクーポンをゲットしましょう！',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}

/// メニューアイテム
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
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
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.grey500,
      ),
      onTap: onTap,
    );
  }
}