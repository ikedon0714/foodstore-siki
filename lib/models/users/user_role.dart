// user_role.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_role.g.dart';

@JsonEnum(alwaysCreate: true) // これを追加
enum UserRole {
  @JsonValue('normal')
  normal,
  @JsonValue('admin')
  admin;

  // Firestoreに保存される文字列（@JsonValueの値）を返す
  String toJson() => _$UserRoleEnumMap[this]!;
}

// ※ build_runnerを実行すると _$UserRoleEnumMap が自動生成されます。