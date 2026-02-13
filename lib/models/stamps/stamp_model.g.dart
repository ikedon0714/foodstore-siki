// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StampModel _$StampModelFromJson(Map json) => _StampModel(
  stampId: json['stampId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  storeId: json['storeId'] as String,
  points: (json['points'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$StampModelToJson(_StampModel instance) =>
    <String, dynamic>{
      'stampId': instance.stampId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'storeId': instance.storeId,
      'points': instance.points,
    };
