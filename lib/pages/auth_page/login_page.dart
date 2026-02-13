import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../notifiers/auth_notifier.dart';
import 'hooks/use_login_form.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ★ここを修正：ロジックはフックへ
    final form = useLoginForm(context: context, ref: ref);

    // 既存の authNotifierProvider を監視（AsyncValue想定）
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('foodstore-siki'),
        bottom: TabBar(
          controller: form.tabController,
          tabs: const [
            Tab(text: 'ログイン'),
            Tab(text: '新規登録'),
          ],
        ),
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
              key: form.formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 12),

                  AppTextField(
                    controller: form.emailController,
                    labelText: 'メールアドレス',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      final value = (v ?? '').trim();
                      if (value.isEmpty) return 'メールアドレスを入力してください';
                      if (!value.contains('@')) return 'メールアドレスの形式が正しくありません';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  AppTextField(
                    controller: form.passwordController,
                    labelText: 'パスワード',
                    obscureText: true,
                    validator: (v) {
                      final value = (v ?? '');
                      if (value.isEmpty) return 'パスワードを入力してください';
                      if (value.length < 6) return '6文字以上で入力してください';
                      return null;
                    },
                  ),

                  if (form.mode == AuthMode.signup) ...[
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: form.confirmPasswordController,
                      labelText: 'パスワード（確認）',
                      obscureText: true,
                      validator: (v) {
                        final value = (v ?? '');
                        if (value.isEmpty) return '確認用パスワードを入力してください';
                        if (value != form.passwordController.text) return 'パスワードが一致しません';
                        return null;
                      },
                    ),
                  ],

                  const SizedBox(height: 24),

                  AppButton(
                    label: form.mode == AuthMode.login ? 'ログイン' : '新規登録',
                    onPressed: form.onSubmit,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    form.mode == AuthMode.login
                        ? 'アカウントをお持ちでない方は「新規登録」へ'
                        : '既にアカウントをお持ちの方は「ログイン」へ',
                    textAlign: TextAlign.center,
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
