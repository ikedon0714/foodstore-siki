import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// スタンプ履歴の表示用軽量モデル
class StampHistoryItem {
  const StampHistoryItem({
    required this.storeName,
    required this.points,
    required this.date,
  });

  final String storeName;
  final int points;
  final DateTime date;
}

class StampHomeViewModel {
  const StampHomeViewModel({
    required this.rankName,
    required this.totalPoints,
    required this.nextRankText,
    required this.historyItems,
    required this.goToScan,
    required this.goToCodeInput,
    required this.onTapViewAllHistory,
  });

  final String rankName;
  final int totalPoints;
  final String? nextRankText;

  final List<StampHistoryItem> historyItems;

  final VoidCallback goToScan;
  final VoidCallback goToCodeInput;
  final VoidCallback onTapViewAllHistory;
}

/// StampHomePage 専用 hook
StampHomeViewModel useStampHome({
  required BuildContext context,
  required WidgetRef ref,
  required dynamic user, // currentUserProvider の型がこの場で確定できないため
}) {
  // 表示用（null安全）
  final rankName = useMemoized(
        () => (user?.userRank?.name as String?) ?? 'レギュラー',
    [user],
  );

  final totalPoints = useMemoized(
        () => (user?.totalPoints as int?) ?? 0,
    [user],
  );

  final nextRankText = useMemoized<String?>(() {
    // 仕様が固まったらここで組み立て
    // final next = user?.userRank?.nextRank;
    // if (next == null) return null;
    // final need = user.userRank.pointsToNextRank(user.totalPoints);
    // return '次のランクまで $needポイント';
    return null;
  }, [user]);

  // 履歴（現状サンプル）
  final historyItems = useMemoized<List<StampHistoryItem>>(
        () => [
      StampHistoryItem(
        storeName: 'サンプル店舗A',
        points: 5,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      StampHistoryItem(
        storeName: 'サンプル店舗B',
        points: 3,
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      StampHistoryItem(
        storeName: 'サンプル店舗C',
        points: 2,
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ],
    const [],
  );

  // 遷移（router方針に合わせて必要なら差し替え）
  void goToScan() => context.push('/stamp/scan');
  void goToCodeInput() => context.push('/stamp/code-input');

  void onTapViewAllHistory() {
    // TODO: 全履歴ページができたら遷移
    // context.push('/stamp/history');
  }

  return StampHomeViewModel(
    rankName: rankName,
    totalPoints: totalPoints,
    nextRankText: nextRankText,
    historyItems: historyItems,
    goToScan: goToScan,
    goToCodeInput: goToCodeInput,
    onTapViewAllHistory: onTapViewAllHistory,
  );
}
