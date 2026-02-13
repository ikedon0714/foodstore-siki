import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'coupon_model.freezed.dart';
part 'coupon_model.g.dart';

@freezed
abstract class CouponModel with _$CouponModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory CouponModel({
    // ドキュメントID
    required String couponId,

    // Firestore timestamps
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,

    // 基本情報
    required String couponName,
    required String couponType,

    // 設計図どおり
    String? description,
    required String imagePath,

    // 利用可能店舗
    @Default(<String>[]) List<String> storeIds,

    // 期限
    @TimestampConverter() required Timestamp deadlineStart,
    @TimestampConverter() required Timestamp deadlineEnd,
  }) = _CouponModel;

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  factory CouponModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('CouponModel.fromFirestore: document data is null (id: ${doc.id})');
    }

    return CouponModel.fromJson({
      ...data as Map<String, dynamic>,
      'couponId': doc.id,
    });
  }

  static Map<String, dynamic> toFirestore(CouponModel coupon) =>
      coupon.toJson()
      // Firestore 側には doc.id を保存しない
        ..remove('couponId');
}
