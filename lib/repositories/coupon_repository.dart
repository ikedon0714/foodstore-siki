import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/coupons/coupon_model.dart';
import 'providers.dart';
import 'repository_exception.dart';

final couponRepositoryProvider = Provider<CouponRepository>((ref) {
  return CouponRepository(ref.watch(firebaseFirestoreProvider));
});

class CouponRepository {
  CouponRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Never _throwRepo(String op, String message, Object error, StackTrace st) {
    developer.log(
      message,
      name: 'CouponRepository/$op',
      error: error,
      stackTrace: st,
    );
    throw RepositoryException.fromFirebase(error, stackTrace: st);
  }

  CollectionReference<CouponModel> get couponsCollection =>
      _firestore.collection('coupons').withConverter<CouponModel>(
        fromFirestore: (snapshot, _) => CouponModel.fromFirestore(snapshot),
        toFirestore: (coupon, _) => CouponModel.toFirestore(coupon),
      );

  DocumentReference<CouponModel> couponDoc(String couponId) =>
      couponsCollection.doc(couponId);

  Future<CouponModel?> getCoupon(String couponId) async {
    try {
      final doc = await couponDoc(couponId).get();
      return doc.data();
    } catch (e, st) {
      _throwRepo('getCoupon', 'Failed to get coupon. couponId=$couponId', e, st);
    }
  }

  Future<List<CouponModel>> getCoupons() async {
    try {
      final snapshot = await couponsCollection
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getCoupons', 'Failed to get coupons.', e, st);
    }
  }

  Stream<List<CouponModel>> watchCoupons() {
    return couponsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  /// 自動ID：doc.id を couponId に注入して set
  Future<DocumentReference<CouponModel>> createCoupon(CouponModel coupon) async {
    try {
      final docRef = couponsCollection.doc();
      final couponWithId = coupon.copyWith(couponId: docRef.id);
      await docRef.set(couponWithId);
      return docRef;
    } catch (e, st) {
      _throwRepo('createCoupon', 'Failed to create coupon.', e, st);
    }
  }

  Future<void> createCouponWithId(String couponId, CouponModel coupon) async {
    try {
      await couponDoc(couponId).set(coupon.copyWith(couponId: couponId));
    } catch (e, st) {
      _throwRepo(
        'createCouponWithId',
        'Failed to create coupon with id. couponId=$couponId',
        e,
        st,
      );
    }
  }

  /// 部分更新 + updatedAt 自動付与（生参照 update）
  Future<void> updateCoupon(String couponId, Map<String, dynamic> data) async {
    try {
      final updateData = <String, dynamic>{
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('coupons').doc(couponId).update(updateData);
    } catch (e, st) {
      _throwRepo(
        'updateCoupon',
        'Failed to update coupon. couponId=$couponId',
        e,
        st,
      );
    }
  }

  Future<void> deleteCoupon(String couponId) async {
    try {
      await couponDoc(couponId).delete();
    } catch (e, st) {
      _throwRepo(
        'deleteCoupon',
        'Failed to delete coupon. couponId=$couponId',
        e,
        st,
      );
    }
  }

  /// ✅ 期限内クーポン（インデックスが必要になる可能性あり）
  Future<List<CouponModel>> getActiveCoupons() async {
    try {
      final now = Timestamp.now();
      final snapshot = await couponsCollection
          .where('deadlineStart', isLessThanOrEqualTo: now)
          .where('deadlineEnd', isGreaterThanOrEqualTo: now)
          .orderBy('deadlineStart')
          .orderBy('deadlineEnd')
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getActiveCoupons', 'Failed to get active coupons.', e, st);
    }
  }

  Stream<List<CouponModel>> watchActiveCoupons() {
    final now = Timestamp.now();
    return couponsCollection
        .where('deadlineStart', isLessThanOrEqualTo: now)
        .where('deadlineEnd', isGreaterThanOrEqualTo: now)
        .orderBy('deadlineStart')
        .orderBy('deadlineEnd')
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Future<List<CouponModel>> getCouponsByType(String couponType) async {
    try {
      final snapshot = await couponsCollection
          .where('couponType', isEqualTo: couponType)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getCouponsByType',
        'Failed to get coupons by type. couponType=$couponType',
        e,
        st,
      );
    }
  }

  Future<List<CouponModel>> getCouponsByStore(String storeId) async {
    try {
      final snapshot = await couponsCollection
          .where('storeIds', arrayContains: storeId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getCouponsByStore',
        'Failed to get coupons by store. storeId=$storeId',
        e,
        st,
      );
    }
  }
}
