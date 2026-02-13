import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';
import 'package:foodstore_siki/notifiers/auth_notifier.dart';
import 'package:foodstore_siki/pages/stamp/stamp_home/hooks/use_stamp_home.dart';
import 'package:foodstore_siki/pages/stamp/stamp_home/widgets/action_buttons.dart';
import 'package:foodstore_siki/pages/stamp/stamp_home/widgets/history_list.dart';
import 'package:foodstore_siki/pages/stamp/stamp_home/widgets/rank_header.dart';

class StampHomePage extends HookConsumerWidget {
  const StampHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    final vm = useStampHome(
      context: context,
      ref: ref,
      user: user,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('スタンプ'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RankHeader(
              rankName: vm.rankName,
              totalPoints: vm.totalPoints,
              nextRankText: vm.nextRankText,
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ActionButtons(
                onTapScan: vm.goToScan,
                onTapCodeInput: vm.goToCodeInput,
              ),
            ),

            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HistoryList(
                items: vm.historyItems,
                onTapViewAll: vm.onTapViewAllHistory,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
