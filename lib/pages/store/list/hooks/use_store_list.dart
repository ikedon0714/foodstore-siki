// lib/pages/store/hooks/use_store_list.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../../../../models/stores/store_model.dart';
import '../../../../notifiers/store_notifier.dart';
import '../widgets/store_filter_sheet.dart';

/// StoreList 用 ViewModel
/// - 状態（State）とアクション（Method）のみ
/// - Widget を返す責務は持たない
class StoreListViewModel {
  StoreListViewModel({
    required this.context,
    required this.ref,
    required this.searchController,
    required this.showSearchBar,
  });

  final BuildContext context;
  final WidgetRef ref;

  /// 検索入力
  final TextEditingController searchController;

  /// 検索バーの表示状態
  final ValueNotifier<bool> showSearchBar;

  // ----------------------------
  // Actions
  // ----------------------------

  void openSearch() {
    showSearchBar.value = true;
    HapticFeedback.selectionClick();
  }

  void closeSearch() {
    searchController.clear();
    ref.read(storeNotifierProvider.notifier).clearSearch();
    showSearchBar.value = false;
    HapticFeedback.selectionClick();
  }

  void setSearchQuery(String q) {
    ref.read(storeNotifierProvider.notifier).setSearchQuery(q);
  }

  Future<void> refresh() async {
    await ref.read(storeNotifierProvider.notifier).refresh();
  }

  void openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const StoreFilterSheet(),
    );
  }

  void resetFilters() {
    ref.read(storeNotifierProvider.notifier).resetFilters();
    searchController.clear();
  }

  void openStoreDetail(StoreModel store) {
    // TODO: 店舗詳細ページを実装したら差し替え
    context.push('/store/detail', extra: store);
  }

  void openStoreAdd() {
    context.push('store/add');
  }
}

/// Hook: StoreList 用ロジックを集約
StoreListViewModel useStoreList(BuildContext context, WidgetRef ref) {
  final controller = useTextEditingController();
  final show = useState<bool>(false);

  return StoreListViewModel(
    context: context,
    ref: ref,
    searchController: controller,
    showSearchBar: show,
  );
}

/// 仮の店舗詳細ページ（後で差し替える想定）
class _StubStoreDetailPage extends StatelessWidget {
  final StoreModel store;

  const _StubStoreDetailPage({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(store.storeName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '店舗詳細ページ（準備中）\n\n'
              'storeId: ${store.storeId}\n'
              'address: ${store.address}\n',
        ),
      ),
    );
  }
}
