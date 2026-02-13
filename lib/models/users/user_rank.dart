import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_rank.g.dart';

@JsonEnum(alwaysCreate: true)
enum UserRank {
  @JsonValue('regular')
  regular,
  @JsonValue('silver')
  silver,
  @JsonValue('gold')
  gold,
  @JsonValue('platinum')
  platinum;

  String toJson() => _$UserRankEnumMap[this]!;
}