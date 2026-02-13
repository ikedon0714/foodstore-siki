import 'package:flutter/material.dart';
import 'package:foodstore_siki/core/widgets/app_main_nav_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/widgets/app_confirm_dialog.dart';
import '../../notifiers/auth_notifier.dart';
import '../../repositories/repository_exception.dart';

/// TopPage（ワイヤーフレーム準拠）
///
/// - ヘッダーに SIKI（ロゴ/大きなテキスト）
/// - メインカード（クーポン/スタンプカード）を縦に2枚
/// - BottomNavigationBar（トップ/スタンプ/クーポン/店舗情報/サブメニュー）
/// - ログアウトは AppConfirmDialog + AppSnackBar を維持
/// - デバッグ情報は削除
/// - Hooks は不要なので ConsumerWidget
class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // user を読んでいても表示に使わない（将来のガードや導線用に残してOK）
    final user = ref.watch(currentUserProvider);

    Future<void> handleSignOut() async {
      final shouldSignOut = await AppConfirmDialog.show(
        context: context,
        title: 'ログアウト',
        message: 'ログアウトしますか？',
        cancelText: 'キャンセル',
        confirmText: 'ログアウト',
        confirmTextColor: AppColors.error,
      );

      if (shouldSignOut != true) return;
      if (!context.mounted) return;

      try {
        await ref.read(authNotifierProvider.notifier).signOut();

        if (!context.mounted) return;
        AppSnackBar.showSuccess(context, 'ログアウトしました');
      } on RepositoryException catch (e) {
        if (!context.mounted) return;
        AppSnackBar.showError(context, e.message);
      } catch (e) {
        if (!context.mounted) return;
        AppSnackBar.showError(context, 'ログアウトに失敗しました: $e');
      }
    }

    void comingSoon(String name) {
      // 仕様上は「準備中」を出すだけ（遷移先ができたら Navigator.push に差し替え）
      AppSnackBar.showError(context, '$nameは準備中です');
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleSpacing: 24,
        title: const _TopHeaderTitle(),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'ログアウト',
            onPressed: handleSignOut,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          children: [
            // ここに “ようこそ” やユーザー名などを入れたい場合は、
            // user が null の場合でも落ちないようにガードして追加してください。
            // 例：Text(user?.userName ?? 'ゲスト')

            const SizedBox(height: 8),

            AppMainNavCard(
              title: 'クーポン',
              subtitle: 'お得なクーポンを確認',
              icon: Icons.local_offer,
              height: 190,
              onTap: () => comingSoon('クーポン'),
            ),

            const SizedBox(height: 16),

            AppMainNavCard(
              title: 'スタンプカード',
              subtitle: '来店スタンプを貯める',
              icon: Icons.credit_card,
              height: 190,
              onTap: () => comingSoon('スタンプカード'),
            ),

            // ワイヤーフレームに無い情報（デバッグなど）は入れない
          ],
        ),
      ),

    );
  }
}

/// ヘッダー（ロゴの代わりに大きな「SIKI」テキスト）
class _TopHeaderTitle extends StatelessWidget {
  const _TopHeaderTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'SIKI',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: 1.5,
      ),
    );
  }
}
