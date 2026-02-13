import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/users/user_model.dart';
import '../models/users/user_role.dart';
import 'providers.dart';
import 'repository_exception.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(firebaseFirestoreProvider));
});

class UserRepository {
  UserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Never _throwRepo(
      String op,
      String message,
      Object error,
      StackTrace st,
      ) {
    developer.log(
      message,
      name: 'UserRepository/$op',
      error: error,
      stackTrace: st,
    );
    throw RepositoryException.fromFirebase(error, stackTrace: st);
  }

  /// users コレクション（型安全）
  CollectionReference<UserModel> get usersCollection =>
      _firestore.collection('users').withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromFirestore(snapshot),
        toFirestore: (user, _) => UserModel.toFirestore(user),
      );

  /// 特定ユーザードキュメント（型安全）
  DocumentReference<UserModel> userDoc(String uid) => usersCollection.doc(uid);

  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await userDoc(uid).get();
      return doc.data(); // exists=false なら null
    } catch (e, st) {
      _throwRepo('getUser', 'Failed to get user. uid=$uid', e, st);
    }
  }

  Stream<UserModel?> watchUser(String uid) {
    return userDoc(uid).snapshots().map((doc) => doc.data());
  }

  /// user.uid をドキュメントIDとして作成
  Future<void> createUser(UserModel user) async {
    try {
      await userDoc(user.uid).set(user);
    } catch (e, st) {
      _throwRepo('createUser', 'Failed to create user. uid=${user.uid}', e, st);
    }
  }

  /// 部分更新：updatedAt を自動付与
  /// ※ withConverter の DocumentReference<UserModel> では update(Map) が扱いにくいので生参照で更新
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      final updateData = <String, dynamic>{
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('users').doc(uid).update(updateData);
    } catch (e, st) {
      _throwRepo('updateUser', 'Failed to update user. uid=$uid', e, st);
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await userDoc(uid).delete();
    } catch (e, st) {
      _throwRepo('deleteUser', 'Failed to delete user. uid=$uid', e, st);
    }
  }

  Future<void> addFavoriteStore(String uid, String storeId) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'favoriteStore': FieldValue.arrayUnion([storeId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e, st) {
      _throwRepo(
        'addFavoriteStore',
        'Failed to add favorite store. uid=$uid storeId=$storeId',
        e,
        st,
      );
    }
  }

  Future<void> removeFavoriteStore(String uid, String storeId) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'favoriteStore': FieldValue.arrayRemove([storeId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e, st) {
      _throwRepo(
        'removeFavoriteStore',
        'Failed to remove favorite store. uid=$uid storeId=$storeId',
        e,
        st,
      );
    }
  }

  Future<void> addPoints(String uid, int points) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'totalPoints': FieldValue.increment(points),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e, st) {
      _throwRepo(
        'addPoints',
        'Failed to add points. uid=$uid points=$points',
        e,
        st,
      );
    }
  }

  Future<void> subtractPoints(String uid, int points) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'totalPoints': FieldValue.increment(-points),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e, st) {
      _throwRepo(
        'subtractPoints',
        'Failed to subtract points. uid=$uid points=$points',
        e,
        st,
      );
    }
  }

  Future<void> updateFailedCount(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'failedCount': FieldValue.increment(1),
        'lastFailedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e, st) {
      _throwRepo(
        'updateFailedCount',
        'Failed to update failed count. uid=$uid',
        e,
        st,
      );
    }
  }

  Future<void> resetFailedCount(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'failedCount': 0,
        'lastFailedAt': null,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e, st) {
      _throwRepo(
        'resetFailedCount',
        'Failed to reset failed count. uid=$uid',
        e,
        st,
      );
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await usersCollection.get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getAllUsers', 'Failed to get all users.', e, st);
    }
  }

  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    try {
      final roleValue = role.toJson(); // @JsonValue 前提
      final snapshot =
      await usersCollection.where('userRole', isEqualTo: roleValue).get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getUsersByRole',
        'Failed to get users by role. role=$role',
        e,
        st,
      );
    }
  }
}
