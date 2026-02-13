import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';


class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      // ★ 未選択の色を指定しないと白飛びして見えない場合があります
      unselectedItemColor: theme.colorScheme.onSurfaceVariant,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'トップ画面'),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'スタンプ'),
        BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'クーポン'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: '店舗一覧'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'サブメニュー'),
      ],
      onTap: onTap,
    );
  }
}
