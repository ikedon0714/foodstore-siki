import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/stamps/stamp_model.dart';
import 'providers.dart';
import 'repository_exception.dart';

final stampRepositoryProvider = Provider<StampRepository>((ref) {
  return StampRepository(ref.watch(firebaseFirestoreProvider));
});

class StampRepository {
  StampRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Never _throwRepo(String op, String message, Object error, StackTrace st) {
    developer.log(
      message,
      name: 'StampRepository/$op',
      error: error,
      stackTrace: st,
    );
    throw RepositoryException.fromFirebase(error, stackTrace: st);
  }

  CollectionReference<StampModel> stampsCollection(String uid) => _firestore
      .collection('users')
      .doc(uid)
      .collection('stamps')
      .withConverter<StampModel>(
    fromFirestore: (snapshot, _) => StampModel.fromFirestore(snapshot),
    toFirestore: (stamp, _) => StampModel.toFirestore(stamp),
  );

  DocumentReference<StampModel> stampDoc(String uid, String stampId) =>
      stampsCollection(uid).doc(stampId);

  Future<StampModel?> getStamp(String uid, String stampId) async {
    try {
      final doc = await stampDoc(uid, stampId).get();
      return doc.data();
    } catch (e, st) {
      _throwRepo('getStamp', 'Failed to get stamp. uid=$uid stampId=$stampId', e, st);
    }
  }

  Future<List<StampModel>> getStamps(String uid) async {
    try {
      final snapshot = await stampsCollection(uid)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getStamps', 'Failed to get stamps. uid=$uid', e, st);
    }
  }

  Stream<List<StampModel>> watchStamps(String uid) {
    return stampsCollection(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((d) => d.data()).toList());
  }

  /// 自動ID：doc.id を stampId に注入して set（ID一貫性）
  Future<DocumentReference<StampModel>> createStamp(String uid, StampModel stamp) async {
    try {
      final docRef = stampsCollection(uid).doc();
      final stampWithId = stamp.copyWith(stampId: docRef.id);
      await docRef.set(stampWithId);
      return docRef;
    } catch (e, st) {
      _throwRepo('createStamp', 'Failed to create stamp. uid=$uid', e, st);
    }
  }

  /// 部分更新 + updatedAt 自動付与（生参照で update）
  Future<void> updateStamp(String uid, String stampId, Map<String, dynamic> data) async {
    try {
      final updateData = <String, dynamic>{
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('stamps')
          .doc(stampId)
          .update(updateData);
    } catch (e, st) {
      _throwRepo(
        'updateStamp',
        'Failed to update stamp. uid=$uid stampId=$stampId',
        e,
        st,
      );
    }
  }

  Future<void> deleteStamp(String uid, String stampId) async {
    try {
      await stampDoc(uid, stampId).delete();
    } catch (e, st) {
      _throwRepo('deleteStamp', 'Failed to delete stamp. uid=$uid stampId=$stampId', e, st);
    }
  }

  Future<List<StampModel>> getStampsByStore(String uid, String storeId) async {
    try {
      final snapshot = await stampsCollection(uid)
          .where('storeId', isEqualTo: storeId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getStampsByStore',
        'Failed to get stamps by store. uid=$uid storeId=$storeId',
        e,
        st,
      );
    }
  }

  Stream<List<StampModel>> watchStampsByStore(String uid, String storeId) {
    return stampsCollection(uid)
        .where('storeId', isEqualTo: storeId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((d) => d.data()).toList());
  }

  /// ✅ count() で爆速（int? 対策で ?? 0）
  Future<int> getStampCountByStore(String uid, String storeId) async {
    try {
      final agg = await _firestore
          .collection('users')
          .doc(uid)
          .collection('stamps')
          .where('storeId', isEqualTo: storeId)
          .count()
          .get();

      return agg.count ?? 0;
    } catch (e, st) {
      _throwRepo(
        'getStampCountByStore',
        'Failed to get stamp count by store. uid=$uid storeId=$storeId',
        e,
        st,
      );
    }
  }

  Future<int> getTotalPointsByStore(String uid, String storeId) async {
    try {
      final stamps = await getStampsByStore(uid, storeId);
      return stamps.fold<int>(0, (sum, s) => sum + s.points);
    } catch (e, st) {
      _throwRepo(
        'getTotalPointsByStore',
        'Failed to get total points by store. uid=$uid storeId=$storeId',
        e,
        st,
      );
    }
  }

  Future<List<StampModel>> getStampsByDateRange(
      String uid, {
        required DateTime startDate,
        required DateTime endDate,
      }) async {
    try {
      final snapshot = await stampsCollection(uid)
          .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getStampsByDateRange',
        'Failed to get stamps by date range. uid=$uid start=$startDate end=$endDate',
        e,
        st,
      );
    }
  }

  Future<void> deleteAllStamps(String uid) async {
    try {
      final snapshot = await stampsCollection(uid).get();
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e, st) {
      _throwRepo('deleteAllStamps', 'Failed to delete all stamps. uid=$uid', e, st);
    }
  }
}
