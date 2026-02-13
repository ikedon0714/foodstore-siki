import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'used_coupon_model.freezed.dart';
part 'used_coupon_model.g.dart';

@freezed
abstract class UsedCouponModel with _$UsedCouponModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory UsedCouponModel({
    // ドキュメントID（サブコレクション側のdoc.id）
    required String usedCouponId,

    // 設計図どおり
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
    required String couponId,
  }) = _UsedCouponModel;

  factory UsedCouponModel.fromJson(Map<String, dynamic> json) =>
      _$UsedCouponModelFromJson(json);

  factory UsedCouponModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError(
        'UsedCouponModel.fromFirestore: document data is null (id: ${doc.id})',
      );
    }
    // doc.id をモデルにも保持
    return UsedCouponModel.fromJson({
      ...data as Map<String, dynamic>,
      'usedCouponId': doc.id,
    });
  }

  static Map<String, dynamic> toFirestore(UsedCouponModel model) =>
      model.toJson()
      // Firestoreには doc.id を通常保存しない（必要なら消す）
        ..remove('usedCouponId');
}
