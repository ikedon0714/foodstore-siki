// lib/core/router/router.dart

import 'package:foodstore_siki/pages/coupon/coupon_detail.dart';
import 'package:foodstore_siki/pages/coupon/coupon_list_page.dart';
import 'package:foodstore_siki/pages/stamp/stamp_home/stamp_page.dart';
import 'package:foodstore_siki/pages/sub_menu/menu_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/stores/store_model.dart';
import '../../notifiers/auth_notifier.dart';
import '../../pages/auth_page/login_page.dart';
import '../../pages/main_shell.dart';
import '../../pages/onboarding/set_basic_info.dart';
import '../../pages/stamp/stamp_code_input/stamp_code_input.dart';
import '../../pages/stamp/stamp_scan/stamp_scan_page.dart';
import '../../pages/store/add/store_add_page.dart'; // ★ここを新規追加
import '../../pages/store/detail/store_detail_page.dart';
import '../../pages/store/list/store_list_page.dart';
import '../../pages/sub_menu/my_page.dart';
import '../../pages/sub_menu/setting_page.dart';
import '../../pages/top/top_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (authState.isLoading) return null;
      final bool loggedIn = authState.value != null;
      if (!loggedIn) return state.matchedLocation == '/login' ? null : '/login';

      final needsBasicInfo = ref.watch(needsBasicInfoProvider);
      if (needsBasicInfo) return state.matchedLocation == '/set-basic-info' ? null : '/set-basic-info';

      if (state.matchedLocation == '/login') return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/set-basic-info', builder: (context, state) => const SetBasicInfoPage()),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const TopPage()),
          // スタンプ関連
          GoRoute(
            path: '/stamps',
            builder: (context, state) => const StampHomePage(),
            routes: [
              GoRoute(path: 'scan', builder: (context, state) => const StampScanPage()),
              GoRoute(path: 'input', builder: (context, state) => const StampCodeInputPage()),
            ],
          ),
          // クーポン関連
          GoRoute(
            path: '/coupons',
            builder: (context, state) => const CouponListPage(),
            routes: [
              GoRoute(
                path: 'detail/:couponId', // :couponId パラメータを追加
                builder: (context, state) {
                  // パスから couponId を取得
                  final couponId = state.pathParameters['couponId']!;
                  // 取得した ID をコンストラクタに渡す
                  return CouponDetailPage(couponId: couponId);
                },
              ),
            ],
          ),
          // 店舗・メニュー
          // 店舗（list / add / detail をネスト化）
          GoRoute(
            path: '/stores',
            builder: (context, state) => const StoreListPage(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const StoreAddPage(), // ★ここを新規追加
              ),
              GoRoute(
                path: 'detail',
                builder: (context, state) {
                  final store = state.extra as StoreModel;
                  return StoreDetailPage(store: store);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/menu',
            builder: (context, state) => const MenuPage(),
            routes: [
              GoRoute(path: 'profile', builder: (context, state) => const MyPage()),
              GoRoute(path: 'settings', builder: (context, state) => const SettingsPage()),
            ],
          ),
        ],
      ),
    ],
  );
});