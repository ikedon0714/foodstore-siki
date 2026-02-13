import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'store_model.freezed.dart';
part 'store_model.g.dart';

@freezed
abstract class StoreModel with _$StoreModel {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory StoreModel({
    // ドキュメントID
    required String storeId,

    // Firestore timestamps
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,

    // 基本情報
    required String storeName,
    required String imagePath,

    // 営業情報
    required String openingHours,          // businessHours -> openingHours
    @Default(<String>[]) List<String> regularHoliday, // businessHoliday -> regularHoliday

    // 連絡先
    required String tellNumber,            // tel -> tellNumber
    required String address,

    // 追加フィールド（設計図どおり）
    required int seats,
    required int parking,
    String? price,
    required String description,
  }) = _StoreModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  factory StoreModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('StoreModel.fromFirestore: document data is null (id: ${doc.id})');
    }

    return StoreModel.fromJson({
      ...data as Map<String, dynamic>,
      'storeId': doc.id, // doc.id をモデルに反映
    });
  }

  static Map<String, dynamic> toFirestore(StoreModel store) =>
      store.toJson()
      // Firestore側には doc.id を保存しない
        ..remove('storeId');
}
