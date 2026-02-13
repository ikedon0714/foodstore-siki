import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // インスタンス化防止

  /// Brand / Primary
  static const Color primary = Color(0xFF2E7D32); // deep green
  static const Color textOnPrimary = Colors.white;
  static const Color textPrimary = Colors.white;
  static const Color primaryDark = Colors.black;

  /// Background
  static const Color background = Color(0xFFF6F7F8);
  static const Color white = Colors.white;

  /// Text
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textTertiary = Color(0xFF9CA3AF); // gray-400

  /// Greys
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);

  /// Status
  static const Color error = Color(0xFFDC2626); // red-600
  static const Color success = Color(0xFF16A34A); // green-600
  /// 軽いドロップシャドウ用
  static const Color shadow = Color(0x33000000); // black 20%

  /// アクセントの薄色（バッジ背景など）
  static const Color accentLight = Color(0xFFFFF3CC); // light yellow

  /// メインアクセントカラー（カード・アイコン用）
  static const Color accent = Color(0xFFFFC107); // amber

  /// 薄いグレー背景（デバッグカードなど）
  static const Color grey100 = Color(0xFFF5F5F5);

  static const info = Colors.blue;
}
