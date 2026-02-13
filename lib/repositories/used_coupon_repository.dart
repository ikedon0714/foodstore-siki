import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/used_coupons/used_coupon_model.dart';
import 'providers.dart';
import 'repository_exception.dart';

final usedCouponRepositoryProvider = Provider<UsedCouponRepository>((ref) {
  return UsedCouponRepository(ref.watch(firebaseFirestoreProvider));
});

class UsedCouponRepository {
  UsedCouponRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Never _throwRepo(String op, String message, Object error, StackTrace st) {
    developer.log(
      message,
      name: 'UsedCouponRepository/$op',
      error: error,
      stackTrace: st,
    );
    throw RepositoryException.fromFirebase(error, stackTrace: st);
  }

  CollectionReference<UsedCouponModel> usedCouponsCollection(String uid) =>
      _firestore
          .collection('users')
          .doc(uid)
          .collection('usedCoupons')
          .withConverter<UsedCouponModel>(
        fromFirestore: (snapshot, _) => UsedCouponModel.fromFirestore(snapshot),
        toFirestore: (model, _) => UsedCouponModel.toFirestore(model),
      );

  DocumentReference<UsedCouponModel> usedCouponDoc(String uid, String usedCouponId) =>
      usedCouponsCollection(uid).doc(usedCouponId);

  Future<UsedCouponModel?> getUsedCoupon(String uid, String usedCouponId) async {
    try {
      final doc = await usedCouponDoc(uid, usedCouponId).get();
      return doc.data();
    } catch (e, st) {
      _throwRepo(
        'getUsedCoupon',
        'Failed to get used coupon. uid=$uid usedCouponId=$usedCouponId',
        e,
        st,
      );
    }
  }

  Future<List<UsedCouponModel>> getUsedCoupons(String uid) async {
    try {
      final snapshot = await usedCouponsCollection(uid)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getUsedCoupons', 'Failed to get used coupons. uid=$uid', e, st);
    }
  }

  Stream<List<UsedCouponModel>> watchUsedCoupons(String uid) {
    return usedCouponsCollection(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  /// ✅ 自動ID：doc.id を usedCouponId に注入して set（ID一貫性）
  Future<DocumentReference<UsedCouponModel>> addUsedCoupon(
      String uid,
      UsedCouponModel usedCoupon,
      ) async {
    try {
      final docRef = usedCouponsCollection(uid).doc();
      final withId = usedCoupon.copyWith(usedCouponId: docRef.id);
      await docRef.set(withId);
      return docRef;
    } catch (e, st) {
      _throwRepo('addUsedCoupon', 'Failed to add used coupon. uid=$uid', e, st);
    }
  }

  Future<void> addUsedCouponWithId(
      String uid,
      String usedCouponId,
      UsedCouponModel usedCoupon,
      ) async {
    try {
      await usedCouponDoc(uid, usedCouponId)
          .set(usedCoupon.copyWith(usedCouponId: usedCouponId));
    } catch (e, st) {
      _throwRepo(
        'addUsedCouponWithId',
        'Failed to add used coupon with id. uid=$uid usedCouponId=$usedCouponId',
        e,
        st,
      );
    }
  }

  /// 部分更新 + updatedAt 自動付与（生参照 update）
  Future<void> updateUsedCoupon(
      String uid,
      String usedCouponId,
      Map<String, dynamic> data,
      ) async {
    try {
      final updateData = <String, dynamic>{
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('usedCoupons')
          .doc(usedCouponId)
          .update(updateData);
    } catch (e, st) {
      _throwRepo(
        'updateUsedCoupon',
        'Failed to update used coupon. uid=$uid usedCouponId=$usedCouponId',
        e,
        st,
      );
    }
  }

  Future<void> deleteUsedCoupon(String uid, String usedCouponId) async {
    try {
      await usedCouponDoc(uid, usedCouponId).delete();
    } catch (e, st) {
      _throwRepo(
        'deleteUsedCoupon',
        'Failed to delete used coupon. uid=$uid usedCouponId=$usedCouponId',
        e,
        st,
      );
    }
  }

  Future<bool> isCouponUsed(String uid, String couponId) async {
    try {
      final snapshot = await usedCouponsCollection(uid)
          .where('couponId', isEqualTo: couponId)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e, st) {
      _throwRepo(
        'isCouponUsed',
        'Failed to check coupon used. uid=$uid couponId=$couponId',
        e,
        st,
      );
    }
  }

  Future<List<UsedCouponModel>> getUsedCouponHistory(String uid, String couponId) async {
    try {
      final snapshot = await usedCouponsCollection(uid)
          .where('couponId', isEqualTo: couponId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getUsedCouponHistory',
        'Failed to get used coupon history. uid=$uid couponId=$couponId',
        e,
        st,
      );
    }
  }

  Stream<List<UsedCouponModel>> watchUsedCouponHistory(String uid, String couponId) {
    return usedCouponsCollection(uid)
        .where('couponId', isEqualTo: couponId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  /// ✅ count() で爆速（int? 対策で ?? 0）
  Future<int> getUsedCouponCount(String uid) async {
    try {
      final agg = await _firestore
          .collection('users')
          .doc(uid)
          .collection('usedCoupons')
          .count()
          .get();
      return agg.count ?? 0;
    } catch (e, st) {
      _throwRepo('getUsedCouponCount', 'Failed to get used coupon count. uid=$uid', e, st);
    }
  }

  /// ✅ count() で爆速（特定couponIdの使用回数）
  Future<int> getCouponUsageCount(String uid, String couponId) async {
    try {
      final agg = await _firestore
          .collection('users')
          .doc(uid)
          .collection('usedCoupons')
          .where('couponId', isEqualTo: couponId)
          .count()
          .get();
      return agg.count ?? 0;
    } catch (e, st) {
      _throwRepo(
        'getCouponUsageCount',
        'Failed to get coupon usage count. uid=$uid couponId=$couponId',
        e,
        st,
      );
    }
  }

  Future<List<UsedCouponModel>> getUsedCouponsByDateRange(
      String uid, {
        required DateTime startDate,
        required DateTime endDate,
      }) async {
    try {
      final snapshot = await usedCouponsCollection(uid)
          .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getUsedCouponsByDateRange',
        'Failed to get used coupons by date range. uid=$uid start=$startDate end=$endDate',
        e,
        st,
      );
    }
  }

  Stream<List<UsedCouponModel>> watchUsedCouponsByDateRange(
      String uid, {
        required DateTime startDate,
        required DateTime endDate,
      }) {
    return usedCouponsCollection(uid)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Future<void> deleteAllUsedCoupons(String uid) async {
    try {
      final snapshot = await usedCouponsCollection(uid).get();
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e, st) {
      _throwRepo('deleteAllUsedCoupons', 'Failed to delete all used coupons. uid=$uid', e, st);
    }
  }
}
