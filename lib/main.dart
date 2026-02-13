// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'core/router/router.dart'; // ★追加：ルーター定義のインポート
import 'core/theme/app_colors.dart'; // 共通テーマなどがあれば

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget { // ★ConsumerWidgetに変更（routerProviderを読み込むため）
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ★routerProviderを監視
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Foodstore Siki',
      debugShowCheckedModeBanner: false,
      // ★routerConfigを指定。home: プロパティは不要になります
      routerConfig: router,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        // 必要に応じてテーマ設定
      ),
    );
  }
}