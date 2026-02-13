// lib/view_models/store_add/malaysian_formatter.dart

/// Flutter の TimeOfDay に依存しないための薄い抽象
abstract class TimeOfDayLike {
  int get hour;
  int get minute;
}

/// マレーシア向けの整形・バリデーションを集約
class MalaysianFormatter {
  static String _cleanPhone(String input) =>
      input.replaceAll(RegExp(r'[-\s+]'), '');

  /// 例: "+60 12-345 6789" / "6012..." / "012-..." -> 国番号(+60/60)を落とした数値へ（従来仕様維持）
  static String formatPhoneForStore(String input) {
    final cleaned = _cleanPhone(input);
    return cleaned.startsWith('60') ? cleaned.substring(2) : cleaned;
  }

  /// +60 / 60 対応（固定・携帯の桁を大きく許容して従来仕様維持）
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return '電話番号を入力してください';

    final cleaned = _cleanPhone(value);

    if (cleaned.startsWith('60')) {
      final number = cleaned.substring(2);
      if (number.length < 9 || number.length > 11) {
        return '正しい電話番号を入力してください';
      }
      return null;
    }

    if (cleaned.length < 9 || cleaned.length > 11) {
      return '正しい電話番号を入力してください';
    }
    if (!cleaned.startsWith('0')) {
      return '電話番号は0で始まる必要があります';
    }
    return null;
  }

  /// 5桁郵便番号（数値）
  static String? validatePostalCode(String? value) {
    if (value == null || value.trim().isEmpty) return '郵便番号を入力してください';
    if (!RegExp(r'^\d{5}$').hasMatch(value.trim())) {
      return '郵便番号は5桁の数値で入力してください';
    }
    return null;
  }

  /// HH:mm
  static String formatTimeOfDay(TimeOfDayLike t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  static String formatOpeningHours({
    required TimeOfDayLike? opening,
    required TimeOfDayLike? closing,
  }) {
    if (opening == null || closing == null) return '';
    return '${formatTimeOfDay(opening)} - ${formatTimeOfDay(closing)}';
  }
}
