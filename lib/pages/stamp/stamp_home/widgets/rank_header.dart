import 'package:flutter/material.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';

class RankHeader extends StatelessWidget {
  const RankHeader({
    super.key,
    required this.rankName,
    required this.totalPoints,
    this.nextRankText,
  });

  final String rankName;
  final int totalPoints;
  final String? nextRankText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                rankName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stars, color: AppColors.accentLight, size: 32),
                const SizedBox(width: 8),
                Text(
                  '$totalPoints',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'ポイント',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (nextRankText != null)
              Text(
                nextRankText!,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
