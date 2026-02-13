import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/stores/store_model.dart';
import '../notifiers/auth_notifier.dart';
import '../repositories/repository_exception.dart';
import '../repositories/store_repository.dart';

/// ===============================
/// フィルタ条件（検索・カテゴリ等）
/// ===============================

typedef StoreFilterState = ({
String searchQuery,
String? category,
bool onlyWithParking,
String? priceRange,
List<String> storeIds, // お気に入り等のID絞り込み用（空なら無効）
});

final storeFilterProvider = StateProvider<StoreFilterState>((ref) {
  return (
  searchQuery: '',
  category: null,
  onlyWithParking: false,
  priceRange: null,
  storeIds: const [],
  );
});

/// 画面側が使いやすいように、フィルタ適用済みの一覧を返すProvider
final filteredStoresProvider = Provider<AsyncValue<List<StoreModel>>>((ref) {
  final storesAsync = ref.watch(storeNotifierProvider);
  final filter = ref.watch(storeFilterProvider);

  return storesAsync.whenData((allStores) {
    return _applyStoreFilters(
      allStores,
      searchQuery: filter.searchQuery,
      category: filter.category,
      onlyWithParking: filter.onlyWithParking,
      priceRange: filter.priceRange,
      storeIds: filter.storeIds,
    );
  });
});

List<StoreModel> _applyStoreFilters(
    List<StoreModel> allStores, {
      required String searchQuery,
      required String? category,
      required bool onlyWithParking,
      required String? priceRange,
      required List<String> storeIds,
    }) {
  Iterable<StoreModel> filtered = allStores;

  // 検索
  final q = searchQuery.trim().toLowerCase();
  if (q.isNotEmpty) {
    filtered = filtered.where((store) {
      return store.storeName.toLowerCase().contains(q) ||
          store.address.toLowerCase().contains(q) ||
          store.description.toLowerCase().contains(q);
    });
  }

  // カテゴリ（将来拡張）
  if (category != null) {
    // TODO: store.category が実装されたら有効化
    // filtered = filtered.where((store) => store.category == category);
  }

  // 駐車場あり
  if (onlyWithParking) {
    filtered = filtered.where((store) => store.parking > 0);
  }

  // 価格帯
  if (priceRange != null) {
    filtered = filtered.where((store) => store.price == priceRange);
  }

  // 特定ID絞り込み（お気に入り等）
  if (storeIds.isNotEmpty) {
    final idSet = storeIds.toSet();
    filtered = filtered.where((store) => idSet.contains(store.storeId));
  }

  return filtered.toList();
}

/// ===============================
/// StoreNotifier（AsyncNotifier / Futureベース）
/// ===============================

class StoreNotifier extends AsyncNotifier<List<StoreModel>> {
  @override
  Future<List<StoreModel>> build() async {
    final repo = ref.watch(storeRepositoryProvider);

    try {
      // 初期データ取得（Stream監視はしない）
      final stores = await repo.getStores();
      return stores;
    } catch (e, stackTrace) {
      throw RepositoryException.fromFirebase(e, stackTrace: stackTrace);
    }
  }

  /// Pull to Refresh 用：ローディング状態を経由して再取得
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(storeRepositoryProvider);

    try {
      final stores = await repo.getStores();
      state = AsyncData(stores);
    } catch (e, stackTrace) {
      state = AsyncError(
        RepositoryException.fromFirebase(e, stackTrace: stackTrace),
        stackTrace,
      );
    }
  }

  // ===============================
  // 以降は「メモリ上のリストに対して」操作する（DB再取得しない）
  // ===============================

  void setSearchQuery(String query) {
    ref.read(storeFilterProvider.notifier).update((s) => (
    searchQuery: query,
    category: s.category,
    onlyWithParking: s.onlyWithParking,
    priceRange: s.priceRange,
    storeIds: s.storeIds,
    ));
  }

  void clearSearch() => setSearchQuery('');

  void setCategory(String? category) {
    ref.read(storeFilterProvider.notifier).update((s) => (
    searchQuery: s.searchQuery,
    category: category,
    onlyWithParking: s.onlyWithParking,
    priceRange: s.priceRange,
    storeIds: s.storeIds,
    ));
  }

  void setOnlyWithParking(bool value) {
    ref.read(storeFilterProvider.notifier).update((s) => (
    searchQuery: s.searchQuery,
    category: s.category,
    onlyWithParking: value,
    priceRange: s.priceRange,
    storeIds: s.storeIds,
    ));
  }

  void setPriceRange(String? priceRange) {
    ref.read(storeFilterProvider.notifier).update((s) => (
    searchQuery: s.searchQuery,
    category: s.category,
    onlyWithParking: s.onlyWithParking,
    priceRange: priceRange,
    storeIds: s.storeIds,
    ));
  }

  void setStoreIdsFilter(List<String> storeIds) {
    ref.read(storeFilterProvider.notifier).update((s) => (
    searchQuery: s.searchQuery,
    category: s.category,
    onlyWithParking: s.onlyWithParking,
    priceRange: s.priceRange,
    storeIds: List.unmodifiable(storeIds),
    ));
  }

  void resetFilters() {
    ref.read(storeFilterProvider.notifier).state = (
    searchQuery: '',
    category: null,
    onlyWithParking: false,
    priceRange: null,
    storeIds: const [],
    );
  }

  /// 並び替え（現在のstateがdataのときのみ、メモリ上の並びを変更）
  void sortBySeats({bool descending = true}) {
    state = state.whenData((stores) {
      final sorted = List<StoreModel>.from(stores)
        ..sort((a, b) => descending
            ? b.seats.compareTo(a.seats)
            : a.seats.compareTo(b.seats));
      return sorted;
    });
  }

  void sortByName({bool ascending = true}) {
    state = state.whenData((stores) {
      final sorted = List<StoreModel>.from(stores)
        ..sort((a, b) => ascending
            ? a.storeName.compareTo(b.storeName)
            : b.storeName.compareTo(a.storeName));
      return sorted;
    });
  }
}

/// StoreNotifierのProvider
final storeNotifierProvider =
AsyncNotifierProvider<StoreNotifier, List<StoreModel>>(
  StoreNotifier.new,
);

/// 店舗数（全件 / フィルタ適用後）
/// ※ filteredStoresProvider を見るので、検索・フィルタ変更に追従する
final storeCountProvider = Provider<({int total, int filtered})>((ref) {
  final allAsync = ref.watch(storeNotifierProvider);
  final filteredAsync = ref.watch(filteredStoresProvider);

  final total = allAsync.maybeWhen(data: (v) => v.length, orElse: () => 0);
  final filtered =
  filteredAsync.maybeWhen(data: (v) => v.length, orElse: () => 0);

  return (total: total, filtered: filtered);
});

/// 特定の店舗を取得（フィルタは無視して「全件」から取得）
final storeByIdProvider = Provider.family<StoreModel?, String>((ref, storeId) {
  final storesAsync = ref.watch(storeNotifierProvider);
  return storesAsync.maybeWhen(
    data: (stores) => stores.firstWhere(
          (s) => s.storeId == storeId,
      orElse: () => throw Exception('Store not found: $storeId'),
    ),
    orElse: () => null,
  );
});

/// お気に入り店舗のみ（フィルタ適用後にしたいなら filteredStoresProvider に差し替え可）
final favoriteStoresProvider = Provider<List<StoreModel>>((ref) {
  final storesAsync = ref.watch(storeNotifierProvider);
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];

  return storesAsync.maybeWhen(
    data: (stores) => stores
        .where((s) => currentUser.favoriteStore.contains(s.storeId))
        .toList(),
    orElse: () => [],
  );
});
