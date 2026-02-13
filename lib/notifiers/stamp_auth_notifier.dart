import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences を Provider 経由で取得（キャッシュされる）
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return SharedPreferences.getInstance();
});

/// Stamp 認証状態
class StampAuthState {
  const StampAuthState({
    required this.failedAttempts,
    required this.isBlocked,
    required this.isLoading,
    this.blockedUntil,
  });

  final int failedAttempts;
  final bool isBlocked;

  /// verifyCode 実行中のローディング（初期ロードとは別）
  final bool isLoading;

  /// ブロック解除日時（表示用 / デバッグ用）
  final DateTime? blockedUntil;

  StampAuthState copyWith({
    int? failedAttempts,
    bool? isBlocked,
    bool? isLoading,
    DateTime? blockedUntil,
  }) {
    return StampAuthState(
      failedAttempts: failedAttempts ?? this.failedAttempts,
      isBlocked: isBlocked ?? this.isBlocked,
      isLoading: isLoading ?? this.isLoading,
      blockedUntil: blockedUntil ?? this.blockedUntil,
    );
  }

  static const initial = StampAuthState(
    failedAttempts: 0,
    isBlocked: false,
    isLoading: false,
    blockedUntil: null,
  );
}

/// verifyCode の結果（UI側で SnackBar 分岐に使う）
sealed class StampAuthResult {
  const StampAuthResult();
}

class StampAuthSuccess extends StampAuthResult {
  const StampAuthSuccess();
}

class StampAuthBlocked extends StampAuthResult {
  const StampAuthBlocked({required this.message});
  final String message;
}

class StampAuthFailure extends StampAuthResult {
  const StampAuthFailure({required this.remainingAttempts, required this.message});
  final int remainingAttempts;
  final String message;
}

/// AsyncNotifier: 初期化で SharedPreferences を await できる
final stampAuthNotifierProvider =
AsyncNotifierProvider<StampAuthNotifier, StampAuthState>(
  StampAuthNotifier.new,
);

class StampAuthNotifier extends AsyncNotifier<StampAuthState> {
  static const String _correctCode = 'siki2026';
  static const int _maxAttempts = 3;

  static const String _kFailedAttempts = 'stamp_code_failed_attempts';
  static const String _kBlockedUntil = 'stamp_code_blocked_until';

  @override
  Future<StampAuthState> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final loaded = await _loadFromPrefs(prefs);
    return loaded;
  }

  /// UI から呼ぶメイン処理
  Future<StampAuthResult> verifyCode(String codeRaw) async {
    final current = state.valueOrNull ?? StampAuthState.initial;

    // 初期ロード中に押された場合のガード
    if (state.isLoading) {
      return const StampAuthBlocked(message: '読み込み中です。もう一度お試しください。');
    }

    if (current.isLoading) return const StampAuthBlocked(message: '処理中です。');

    final prefs = await ref.read(sharedPreferencesProvider.future);

    // 最新状態を prefs から再評価（ブロック期限切れ解除など）
    final refreshed = await _loadFromPrefs(prefs);
    state = AsyncData(refreshed);

    if (refreshed.isBlocked) {
      return const StampAuthBlocked(
        message: '本日の認証回数を超過しました。明日再度お試しください。',
      );
    }

    final code = codeRaw.trim();
    if (code.isEmpty) {
      return const StampAuthFailure(
        remainingAttempts: _maxAttempts,
        message: '認証コードを入力してください',
      );
    }

    // verify 実行中フラグ
    state = AsyncData(refreshed.copyWith(isLoading: true));

    try {
      // ここに API 呼び出し等が入る想定（現状はローカル判定）
      await Future.delayed(const Duration(milliseconds: 300));

      if (code == _correctCode) {
        await _reset(prefs);
        state = const AsyncData(StampAuthState.initial);
        return const StampAuthSuccess();
      }

      // 失敗
      final nextAttempts = (refreshed.failedAttempts + 1).clamp(0, _maxAttempts);
      await prefs.setInt(_kFailedAttempts, nextAttempts);

      if (nextAttempts >= _maxAttempts) {
        final blockedUntil = _tomorrowStart(DateTime.now());
        await prefs.setString(_kBlockedUntil, blockedUntil.toIso8601String());

        state = AsyncData(
          StampAuthState(
            failedAttempts: _maxAttempts,
            isBlocked: true,
            isLoading: false,
            blockedUntil: blockedUntil,
          ),
        );

        return const StampAuthBlocked(
          message: '認証に3回失敗しました。本日はこれ以上使用できません。',
        );
      }

      final remaining = _maxAttempts - nextAttempts;
      state = AsyncData(
        StampAuthState(
          failedAttempts: nextAttempts,
          isBlocked: false,
          isLoading: false,
          blockedUntil: null,
        ),
      );

      return StampAuthFailure(
        remainingAttempts: remaining,
        message: '認証コードが間違っています。残り$remaining回',
      );
    } catch (e) {
      // 例外時はローディング解除
      final nowState = state.valueOrNull ?? StampAuthState.initial;
      state = AsyncData(nowState.copyWith(isLoading: false));
      return StampAuthFailure(
        remainingAttempts: _maxAttempts - refreshed.failedAttempts,
        message: '処理に失敗しました: $e',
      );
    }
  }

  Future<StampAuthState> _loadFromPrefs(SharedPreferences prefs) async {
    final attempts = prefs.getInt(_kFailedAttempts) ?? 0;
    final blockedUntilStr = prefs.getString(_kBlockedUntil);

    if (blockedUntilStr == null) {
      return StampAuthState(
        failedAttempts: attempts.clamp(0, _maxAttempts),
        isBlocked: false,
        isLoading: false,
        blockedUntil: null,
      );
    }

    final blockedUntil = DateTime.tryParse(blockedUntilStr);
    if (blockedUntil == null) {
      // 壊れたデータは掃除
      await prefs.remove(_kBlockedUntil);
      return StampAuthState(
        failedAttempts: attempts.clamp(0, _maxAttempts),
        isBlocked: false,
        isLoading: false,
        blockedUntil: null,
      );
    }

    final now = DateTime.now();
    if (now.isBefore(blockedUntil)) {
      return StampAuthState(
        failedAttempts: _maxAttempts,
        isBlocked: true,
        isLoading: false,
        blockedUntil: blockedUntil,
      );
    }

    // 期限切れ：解除してリセット
    await _reset(prefs);
    return StampAuthState.initial;
  }

  Future<void> _reset(SharedPreferences prefs) async {
    await prefs.remove(_kFailedAttempts);
    await prefs.remove(_kBlockedUntil);
  }

  DateTime _tomorrowStart(DateTime now) {
    final tomorrow = now.add(const Duration(days: 1));
    return DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  }
}
