import 'package:freezed_annotation/freezed_annotation.dart';

part 'gender.g.dart';

@JsonEnum(alwaysCreate: true)
enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('other')
  other,
  @JsonValue('unknown')
  unknown;

  String toJson() => _$GenderEnumMap[this]!;
}