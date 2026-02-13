import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppMainNavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final double height;
  final VoidCallback onTap;
  final String? imagePath; // 将来的に画像パスを受け取れるように拡張

  const AppMainNavCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.height,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.grey500,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 背景エリア
              Positioned.fill(
                child: imagePath != null
                    ? Image.asset(imagePath!, fit: BoxFit.cover)
                    : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.10),
                        AppColors.primaryDark.withOpacity(0.06),
                      ],
                    ),
                  ),
                ),
              ),
              // ... (残りのUIロジックは現在の _MainNavCard と同じ) ...
              // コンテンツエリア
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // アイコン（左上または右上に配置）
                    Icon(icon, color: AppColors.primary, size: 32),
                    const Spacer(),
                    // タイトル
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // サブタイトル
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}