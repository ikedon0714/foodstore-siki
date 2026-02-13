import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/users/user_model.dart';
import 'providers.dart';
import 'repository_exception.dart';
import 'user_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(userRepositoryProvider),
  );
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges; // ← 既存 getter をそのまま使える
});

class AuthRepository {
  AuthRepository(this._auth, this._userRepository);

  final FirebaseAuth _auth;
  final UserRepository _userRepository;

  Never _throwRepo(String op, String message, Object error, StackTrace st) {
    developer.log(
      message,
      name: 'AuthRepository/$op',
      error: error,
      stackTrace: st,
    );
    throw RepositoryException.fromFirebase(error, stackTrace: st);
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  /// 認証後に users/{uid} が無ければ初期作成
  Future<void> _ensureUserDocument(User firebaseUser) async {
    final uid = firebaseUser.uid;
    final existing = await _userRepository.getUser(uid);
    if (existing != null) return;

    // ✅ ここはあなたのプロジェクトにある UserModel.initial(uid: ...) を前提
    final initialUser = UserModel.initial(uid: uid);
    await _userRepository.createUser(initialUser);
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user != null) {
        await _ensureUserDocument(user);
      }
      return cred;
    } catch (e, st) {
      _throwRepo(
        'signInWithEmailAndPassword',
        'Failed to sign in with email/password. email=$email',
        e,
        st,
      );
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user != null) {
        await _ensureUserDocument(user);
      }
      return cred;
    } catch (e, st) {
      _throwRepo(
        'signUpWithEmailAndPassword',
        'Failed to sign up with email/password. email=$email',
        e,
        st,
      );
    }
  }

  Future<UserCredential> signInAnonymously() async {
    try {
      final cred = await _auth.signInAnonymously();
      final user = cred.user;
      if (user != null) {
        await _ensureUserDocument(user);
      }
      return cred;
    } catch (e, st) {
      _throwRepo('signInAnonymously', 'Failed to sign in anonymously.', e, st);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e, st) {
      _throwRepo(
        'sendPasswordResetEmail',
        'Failed to send password reset email. email=$email',
        e,
        st,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, st) {
      _throwRepo('signOut', 'Failed to sign out.', e, st);
    }
  }
}
