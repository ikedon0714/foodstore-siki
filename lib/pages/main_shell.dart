import 'package:flutter/material.dart';
import 'package:foodstore_siki/core/widgets/navigation/app_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // 現在のパスからインデックスを特定するロジック
    final String location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child, // ここに各ページが表示される
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _calculateSelectedIndex(location),
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/stamps')) return 1;
    if (location.startsWith('/coupons')) return 2;
    if (location.startsWith('/stores')) return 3; // 詳細ページ(/stores/detail)も3に含まれる
    if (location.startsWith('/menu')) return 4;
    return 0; // デフォルトはトップ画面
  }

  /// ボトムナビタップ時の遷移処理
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/stamps');
        break;
      case 2:
        context.go('/coupons');
        break;
      case 3:
        context.go('/stores');
        break;
      case 4:
        context.go('/menu');
        break;
    }
  }
}