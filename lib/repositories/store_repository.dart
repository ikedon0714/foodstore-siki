import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/stores/store_model.dart';
import 'providers.dart';
import 'repository_exception.dart';

final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  return StoreRepository(ref.watch(firebaseFirestoreProvider));
});

class StoreRepository {
  StoreRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Never _throwRepo(String op, String message, Object error, StackTrace st) {
    developer.log(
      message,
      name: 'StoreRepository/$op',
      error: error,
      stackTrace: st,
    );
    throw RepositoryException.fromFirebase(error, stackTrace: st);
  }

  CollectionReference<StoreModel> get storesCollection =>
      _firestore.collection('stores').withConverter<StoreModel>(
        fromFirestore: (snapshot, _) => StoreModel.fromFirestore(snapshot),
        toFirestore: (store, _) => StoreModel.toFirestore(store),
      );

  DocumentReference<StoreModel> storeDoc(String storeId) =>
      storesCollection.doc(storeId);

  Future<StoreModel?> getStore(String storeId) async {
    try {
      final doc = await storeDoc(storeId).get();
      return doc.data();
    } catch (e, st) {
      _throwRepo('getStore', 'Failed to get store. storeId=$storeId', e, st);
    }
  }

  Future<List<StoreModel>> getStores() async {
    try {
      final snapshot = await storesCollection.orderBy('storeName').get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getStores', 'Failed to get stores.', e, st);
    }
  }

  Stream<List<StoreModel>> watchStores() {
    return storesCollection.orderBy('storeName').snapshots().map(
          (snapshot) => snapshot.docs.map((d) => d.data()).toList(),
    );
  }

  Stream<StoreModel?> watchStore(String storeId) {
    return storeDoc(storeId).snapshots().map((doc) => doc.data());
  }

  /// 自動IDで作成：doc.id を storeId に注入して set（ID一貫性）
  Future<DocumentReference<StoreModel>> createStore(StoreModel store) async {
    try {
      final docRef = storesCollection.doc();
      final storeWithId = store.copyWith(storeId: docRef.id);
      await docRef.set(storeWithId);
      return docRef;
    } catch (e, st) {
      _throwRepo('createStore', 'Failed to create store.', e, st);
    }
  }

  Future<void> createStoreWithId(String storeId, StoreModel store) async {
    try {
      await storeDoc(storeId).set(store.copyWith(storeId: storeId));
    } catch (e, st) {
      _throwRepo(
        'createStoreWithId',
        'Failed to create store with id. storeId=$storeId',
        e,
        st,
      );
    }
  }

  /// 部分更新 + updatedAt 自動付与
  Future<void> updateStore(String storeId, Map<String, dynamic> data) async {
    try {
      final updateData = <String, dynamic>{
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('stores').doc(storeId).update(updateData);
    } catch (e, st) {
      _throwRepo(
        'updateStore',
        'Failed to update store. storeId=$storeId',
        e,
        st,
      );
    }
  }

  Future<void> deleteStore(String storeId) async {
    try {
      await storeDoc(storeId).delete();
    } catch (e, st) {
      _throwRepo(
        'deleteStore',
        'Failed to delete store. storeId=$storeId',
        e,
        st,
      );
    }
  }

  /// 店舗名で検索（前方一致）
  Future<List<StoreModel>> searchStoresByName(String storeName) async {
    try {
      final snapshot = await storesCollection
          .where('storeName', isGreaterThanOrEqualTo: storeName)
          .where('storeName', isLessThan: '$storeName\uf8ff')
          .orderBy('storeName')
          .get();

      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'searchStoresByName',
        'Failed to search stores by name. storeName=$storeName',
        e,
        st,
      );
    }
  }

  /// 住所で検索（部分一致）
  /// ※ Firestore では contains できないため、全件取得してメモリ上で contains フィルタします
  Future<List<StoreModel>> searchStoresByAddress(String address) async {
    try {
      final snapshot = await storesCollection.get();
      return snapshot.docs
          .map((d) => d.data())
          .where((store) => store.address.contains(address))
          .toList();
    } catch (e, st) {
      _throwRepo(
        'searchStoresByAddress',
        'Failed to search stores by address. address=$address',
        e,
        st,
      );
    }
  }

  Future<List<StoreModel>> getStoresByMinSeats(int minSeats) async {
    try {
      final snapshot = await storesCollection
          .where('seats', isGreaterThanOrEqualTo: minSeats)
          .orderBy('seats', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getStoresByMinSeats',
        'Failed to get stores by min seats. minSeats=$minSeats',
        e,
        st,
      );
    }
  }

  Future<List<StoreModel>> getStoresWithParking() async {
    try {
      final snapshot = await storesCollection
          .where('parking', isGreaterThan: 0)
          .orderBy('parking', descending: true)
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo('getStoresWithParking', 'Failed to get stores with parking.', e, st);
    }
  }

  Future<List<StoreModel>> getStoresByPriceRange(String priceRange) async {
    try {
      final snapshot = await storesCollection
          .where('price', isEqualTo: priceRange)
          .orderBy('storeName')
          .get();
      return snapshot.docs.map((d) => d.data()).toList();
    } catch (e, st) {
      _throwRepo(
        'getStoresByPriceRange',
        'Failed to get stores by price range. priceRange=$priceRange',
        e,
        st,
      );
    }
  }

  Future<List<StoreModel>> getStoresByIds(List<String> storeIds) async {
    try {
      if (storeIds.isEmpty) return [];

      const chunkSize = 10; // 将来の制限変動に備えて分割は維持
      final chunks = <List<String>>[
        for (var i = 0; i < storeIds.length; i += chunkSize)
          storeIds.sublist(i, (i + chunkSize).clamp(0, storeIds.length)),
      ];

      final results = <StoreModel>[];
      for (final chunk in chunks) {
        final snapshot = await storesCollection
            .where(FieldPath.documentId, whereIn: chunk)
            .get();
        results.addAll(snapshot.docs.map((d) => d.data()));
      }
      return results;
    } catch (e, st) {
      _throwRepo(
        'getStoresByIds',
        'Failed to get stores by ids. count=${storeIds.length}',
        e,
        st,
      );
    }
  }

  Future<bool> existsStore(String storeId) async {
    try {
      final doc = await _firestore.collection('stores').doc(storeId).get();
      return doc.exists;
    } catch (e, st) {
      _throwRepo('existsStore', 'Failed to check store existence. storeId=$storeId', e, st);
    }
  }

  /// ✅ 店舗数（count() で爆速）
  Future<int> getStoreCount() async {
    try {
      final agg = await _firestore.collection('stores').count().get();
      return agg.count ?? 0;
    } catch (e, st) {
      _throwRepo('getStoreCount', 'Failed to get store count.', e, st);
    }
  }
}
