// lib/pages/store/store_list_page.dart
import 'package:flutter/material.dart';
import 'package:foodstore_siki/notifiers/auth_notifier.dart';
import 'package:foodstore_siki/pages/store/store_add_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../notifiers/store_notifier.dart';
import 'hooks/use_store_list.dart';
import 'widgets/store_card.dart';
import 'widgets/store_list_header.dart';

class StoreListPage extends HookConsumerWidget {
  const StoreListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = useStoreList(context, ref);

    final storesAsync = ref.watch(filteredStoresProvider);
    final storeCount = ref.watch(storeCountProvider);

    final user = ref.watch(currentUserProvider);
    final isAdmin = user?.isAdmin ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _StoreListAppBar(vm: vm),
      body: Column(
        children: [
          StoreListHeader(
            filtered: storeCount.filtered,
            total: storeCount.total,
            onReset: vm.resetFilters,
          ),
          Expanded(
            child: storesAsync.when(
              loading: () => const _LoadingView(),
              error: (error, _) => _ErrorView(
                message: '店舗の取得に失敗しました',
                detail: error.toString(),
                onRetry: vm.refresh,
              ),
              data: (stores) {
                if (stores.isEmpty) {
                  return _EmptyView(onRefresh: vm.refresh);
                }

                return RefreshIndicator(
                  onRefresh: vm.refresh,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      final store = stores[index];
                      return StoreCard(
                        store: store,
                        onTap: () => vm.openStoreDetail(store),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: isAdmin
        ? FloatingActionButton( // ★ここを新規追加
          tooltip: '店舗を追加',
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const StoreAddPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        )
        : null,
      // bottomNavigationBar: const AppBottomNav(),
    );
  }
}

/// AppBar（検索バー切り替えは Page 側で AnimatedSwitcher ）
class _StoreListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final StoreListViewModel vm;

  const _StoreListAppBar({required this.vm});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) {
          return FadeTransition(
            opacity: anim,
            child: SizeTransition(
              sizeFactor: anim,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: vm.showSearchBar.value
            ? TextField(
              key: const ValueKey('searchField'),
              controller: vm.searchController,
              autofocus: true,
              style: TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: '店舗名・住所で検索',
                hintStyle: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
              ),
              onChanged: vm.setSearchQuery,
            )
            : const Text(
              '店舗一覧',
              key: ValueKey('title'),
            ),
      ),
      actions: [
        if (vm.showSearchBar.value)
          IconButton(
            tooltip: '検索を閉じる',
            icon: const Icon(Icons.close),
            onPressed: vm.closeSearch,
          )
        else ...[
          IconButton(
            tooltip: '検索',
            icon: const Icon(Icons.search),
            onPressed: vm.openSearch,
          ),
          IconButton(
            tooltip: 'フィルタ',
            icon: const Icon(Icons.filter_list),
            onPressed: vm.openFilterSheet,
          ),
        ],
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    // RefreshIndicator を成立させるためスクロール可能にする
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 120),
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 16),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyView({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 120),
          Icon(Icons.store_outlined, size: 64, color: AppColors.grey400),
          const SizedBox(height: 16),
          Text(
            '店舗が見つかりませんでした',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final String detail;
  final Future<void> Function() onRetry;

  const _ErrorView({
    required this.message,
    required this.detail,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => onRetry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              child: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}
