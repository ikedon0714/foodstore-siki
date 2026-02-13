import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreDetailViewModel {
  final bool isFollowing;
  final VoidCallback toggleFollow;
  final void Function(int index) onBottomNavTap;

  StoreDetailViewModel({
    required this.isFollowing,
    required this.toggleFollow,
    required this.onBottomNavTap,
  });
}

StoreDetailViewModel useStoreDetail({
  required BuildContext context,
  required WidgetRef ref,
}) {
  final isFollowing = useState<bool>(false);

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(isFollowing.value ? 'フォローしました' : 'フォローを解除しました'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void onBottomNavTap(int index) {
    // 実際はルーティングに置き換え
    if (index == 3) return;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('タブ${index + 1}が選択されました'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  return StoreDetailViewModel(
    isFollowing: isFollowing.value,
    toggleFollow: toggleFollow,
    onBottomNavTap: onBottomNavTap,
  );
}
