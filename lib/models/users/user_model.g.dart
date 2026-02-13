// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map json) => _UserModel(
  uid: json['uid'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  userName: json['userName'] as String,
  imagePath: json['imagePath'] as String?,
  birthday: const NullableTimestampConverter().fromJson(json['birthday']),
  gender:
      $enumDecodeNullable(_$GenderEnumMap, json['gender']) ?? Gender.unknown,
  favoriteStore:
      (json['favoriteStore'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  downloadStore: json['downloadStore'] as String?,
  userRank:
      $enumDecodeNullable(_$UserRankEnumMap, json['userRank']) ??
      UserRank.regular,
  totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
  lastFailedAt: const NullableTimestampConverter().fromJson(
    json['lastFailedAt'],
  ),
  failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
  userRole:
      $enumDecodeNullable(_$UserRoleEnumMap, json['userRole']) ??
      UserRole.normal,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'userName': instance.userName,
      'imagePath': instance.imagePath,
      'birthday': const NullableTimestampConverter().toJson(instance.birthday),
      'gender': instance.gender.toJson(),
      'favoriteStore': instance.favoriteStore,
      'downloadStore': instance.downloadStore,
      'userRank': instance.userRank.toJson(),
      'totalPoints': instance.totalPoints,
      'lastFailedAt': const NullableTimestampConverter().toJson(
        instance.lastFailedAt,
      ),
      'failedCount': instance.failedCount,
      'userRole': instance.userRole.toJson(),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
  Gender.unknown: 'unknown',
};

const _$UserRankEnumMap = {
  UserRank.regular: 'regular',
  UserRank.silver: 'silver',
  UserRank.gold: 'gold',
  UserRank.platinum: 'platinum',
};

const _$UserRoleEnumMap = {UserRole.normal: 'normal', UserRole.admin: 'admin'};
