// auth_notifier.dart
import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repositories/repository_exception.dart';
import '../models/users/gender.dart';
import '../models/users/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

/// 認証とユーザー状態を管理するNotifier
///
/// - AuthRepository の authStateChanges を監視してログイン状態を同期
/// - ログイン時は UserRepository から UserModel を取得して state に載せる
/// - ユーザー初期作成は AuthRepository 側で完結（Notifier 側では作らない）
class AuthNotifier extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final userRepository = ref.watch(userRepositoryProvider);

    // authStateChanges を listen して state を同期（購読解除は Riverpod が自動で扱う）
    ref.listen<AsyncValue<dynamic>>(
      authStateChangesProvider,
          (prev, next) async {
        final user = next.valueOrNull;
        if (user == null) {
          state = const AsyncData(null);
          return;
        }

        try {
          // AuthRepository 側で _ensureUserDocument 済み想定
          final userModel = await userRepository.getUser(user.uid);
          state = AsyncData(userModel);
        } catch (e, st) {
          developer.log(
            'Failed to fetch user from Firestore on auth change',
            name: 'AuthNotifier',
            error: e,
            stackTrace: st,
          );
          state = AsyncError(e, st);
        }
      },
    );

    // 初期値
    final current = authRepository.currentUser;
    if (current == null) return null;

    try {
      final userModel = await userRepository.getUser(current.uid);
      return userModel;
    } catch (e, st) {
      developer.log(
        'Failed to fetch initial user from Firestore',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      // 初期取得失敗は null で返しつつ、state はエラーにしない（UI側で再試行できるように）
      return null;
    }
  }

  /// メールアドレスとパスワードでログイン
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // state 更新は authStateChanges 経由で自動反映
    } on RepositoryException catch (e, st) {
      developer.log(
        'signIn failed',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    } catch (e, st) {
      developer.log(
        'signIn unexpected error',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// メールアドレスとパスワードで新規登録
  ///
  /// ※ Firestore 初期 user 作成は AuthRepository 内で完結している想定
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      // state 更新は authStateChanges 経由で自動反映
    } on RepositoryException catch (e, st) {
      developer.log(
        'signUp failed',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    } catch (e, st) {
      developer.log(
        'signUp unexpected error',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// 匿名ログイン
  ///
  /// ※ Firestore 初期 user 作成は AuthRepository 内で完結している想定
  Future<void> signInAnonymously() async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.signInAnonymously();
      // state 更新は authStateChanges 経由で自動反映
    } on RepositoryException catch (e, st) {
      developer.log(
        'signInAnonymously failed',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    } catch (e, st) {
      developer.log(
        'signInAnonymously unexpected error',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// ログアウト
  Future<void> signOut() async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.signOut();
      // state 更新は authStateChanges 経由で自動反映（null になる）
    } on RepositoryException catch (e, st) {
      developer.log(
        'signOut failed',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    } catch (e, st) {
      developer.log(
        'signOut unexpected error',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// ユーザー情報を再取得（リロード）
  Future<void> reloadUser() async {
    final authRepository = ref.read(authRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);

    final current = authRepository.currentUser;
    if (current == null) {
      state = const AsyncData(null);
      return;
    }

    state = const AsyncLoading();
    try {
      final userModel = await userRepository.getUser(current.uid);
      state = AsyncData(userModel);
    } on RepositoryException catch (e, st) {
      developer.log(
        'reloadUser failed',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
    } catch (e, st) {
      developer.log(
        'reloadUser unexpected error',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
    }
  }

  /// 基本情報を設定（初回登録/初期設定）
  ///
  /// - Firestore にユーザーが無い場合は UserModel.initial(uid) を使って作成
  /// - 既にある場合は部分更新
  Future<void> setBasicInfo({
    required String userName,
    Gender? gender,
    DateTime? birthday,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);

    final current = authRepository.currentUser;
    if (current == null) {
      final e = RepositoryException('not-authenticated', 'ログインしていません');
      state = AsyncError(e, StackTrace.current);
      throw e;
    }

    state = const AsyncLoading();

    try {
      final uid = current.uid;
      final existing = await userRepository.getUser(uid);

      if (existing == null) {
        // 新規作成（initial をベースに必要項目だけ差し替え）
        final base = UserModel.initial(uid: uid);

        final created = base.copyWith(
          userName: userName,
          gender: gender ?? base.gender,
          birthday: birthday != null ? Timestamp.fromDate(birthday) : base.birthday,
          // createdAt/updatedAt は initial が Timestamp.now() を入れる設計
        );

        await userRepository.createUser(created);
        state = AsyncData(created);
        return;
      }

      // 既存ユーザーは部分更新
      final updateData = <String, dynamic>{
        'userName': userName,
      };

      if (gender != null) {
        updateData['gender'] = gender.toJson(); // ✅ @JsonValue の保存値で統一
      }

      if (birthday != null) {
        updateData['birthday'] = Timestamp.fromDate(birthday);
      }

      await userRepository.updateUser(uid, updateData);

      final updated = await userRepository.getUser(uid);
      state = AsyncData(updated);
    } on RepositoryException catch (e, st) {
      developer.log(
        'setBasicInfo failed',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    } catch (e, st) {
      developer.log(
        'setBasicInfo unexpected error',
        name: 'AuthNotifier',
        error: e,
        stackTrace: st,
      );
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

/// AuthNotifierのProvider
final authNotifierProvider =
AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);

/// ログイン状態を判定するProvider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});

/// 初期設定が必要かどうかを判定するProvider
///
/// - 「ログインしている」かつ「userName が空（initial のまま）」なら true
final needsBasicInfoProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    data: (user) => user != null && user.userName.trim().isEmpty,
    orElse: () => false,
  );
});

/// 現在のユーザーモデルを取得するProvider
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    data: (user) => user,
    orElse: () => null,
  );
});

/// 現在のユーザーIDを取得するProvider
final currentUserIdProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.uid;
});
