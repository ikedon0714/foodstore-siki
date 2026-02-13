// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UsedCouponModel _$UsedCouponModelFromJson(Map json) => _UsedCouponModel(
  usedCouponId: json['usedCouponId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  couponId: json['couponId'] as String,
);

Map<String, dynamic> _$UsedCouponModelToJson(_UsedCouponModel instance) =>
    <String, dynamic>{
      'usedCouponId': instance.usedCouponId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'couponId': instance.couponId,
    };
