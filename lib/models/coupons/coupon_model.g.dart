// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CouponModel _$CouponModelFromJson(Map json) => _CouponModel(
  couponId: json['couponId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  couponName: json['couponName'] as String,
  couponType: json['couponType'] as String,
  description: json['description'] as String?,
  imagePath: json['imagePath'] as String,
  storeIds:
      (json['storeIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  deadlineStart: const TimestampConverter().fromJson(json['deadlineStart']),
  deadlineEnd: const TimestampConverter().fromJson(json['deadlineEnd']),
);

Map<String, dynamic> _$CouponModelToJson(
  _CouponModel instance,
) => <String, dynamic>{
  'couponId': instance.couponId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'couponName': instance.couponName,
  'couponType': instance.couponType,
  'description': instance.description,
  'imagePath': instance.imagePath,
  'storeIds': instance.storeIds,
  'deadlineStart': const TimestampConverter().toJson(instance.deadlineStart),
  'deadlineEnd': const TimestampConverter().toJson(instance.deadlineEnd),
};
