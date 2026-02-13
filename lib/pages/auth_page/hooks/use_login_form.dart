import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/app_snack_bar.dart';
import '../../../notifiers/auth_notifier.dart';

enum AuthMode { login, signup }

/// LoginPage のフォーム状態と送信ロジックをまとめたカスタムフック
UseLoginFormResult useLoginForm({
  required BuildContext context,
  required WidgetRef ref,
}) {
  // FormKey
  final formKey = useMemoized(() => GlobalKey<FormState>());

  // Controllers
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();
  final confirmPasswordController = useTextEditingController();

  // TabController + mode
  final tabController = useTabController(initialLength: 2);
  final mode = useState<AuthMode>(AuthMode.login);

  // TabController と mode の同期（Listener + cleanup）
  useEffect(() {
    void listener() {
      if (tabController.indexIsChanging) return;

      final newMode = tabController.index == 0 ? AuthMode.login : AuthMode.signup;
      if (mode.value != newMode) {
        mode.value = newMode;
      }
    }

    tabController.addListener(listener);
    return () => tabController.removeListener(listener);
  }, [tabController]);

  Future<void> onSubmit() async {
    final currentState = formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    try {
      if (mode.value == AuthMode.login) {
        // ★現在仕様を維持
        await ref.read(authNotifierProvider.notifier).signIn(
          email: email,
          password: password,
        );
      } else {
        final confirm = confirmPasswordController.text;
        if (password != confirm) {
          // ★現在仕様を維持
          AppSnackBar.showError(context, 'パスワードが一致しません');
          return;
        }

        // ★現在仕様を維持
        await ref.read(authNotifierProvider.notifier).signUp(
          email: email,
          password: password,
        );
      }
    } catch (e) {
      // ★現在仕様を維持
      if (!context.mounted) return;
      AppSnackBar.showError(context, e.toString());
    }
  }

  return UseLoginFormResult(
    formKey: formKey,
    emailController: emailController,
    passwordController: passwordController,
    confirmPasswordController: confirmPasswordController,
    tabController: tabController,
    mode: mode.value,
    onSubmit: onSubmit,
  );
}

/// useLoginForm の戻り値
class UseLoginFormResult {
  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final TabController tabController;
  final AuthMode mode;

  final Future<void> Function() onSubmit;

  const UseLoginFormResult({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.tabController,
    required this.mode,
    required this.onSubmit,
  });
}
