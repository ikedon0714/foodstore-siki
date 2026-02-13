import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'stamp_model.freezed.dart';
part 'stamp_model.g.dart';

@freezed
abstract class StampModel with _$StampModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory StampModel({
    // ドキュメントIDの保持
    required String stampId,

    // 設計図どおり
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
    required String storeId,

    // デフォルト値（設計図: points）
    @Default(1) int points,
  }) = _StampModel;

  factory StampModel.fromJson(Map<String, dynamic> json) =>
      _$StampModelFromJson(json);

  factory StampModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('StampModel.fromFirestore: document data is null (id: ${doc.id})');
    }
    return StampModel.fromJson(data as Map<String, dynamic>);
  }

  static Map<String, dynamic> toFirestore(StampModel stamp) => stamp.toJson();
}
