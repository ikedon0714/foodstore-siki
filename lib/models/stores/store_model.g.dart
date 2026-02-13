// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoreModel _$StoreModelFromJson(Map json) => _StoreModel(
  storeId: json['storeId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  storeName: json['storeName'] as String,
  imagePath: json['imagePath'] as String,
  openingHours: json['openingHours'] as String,
  regularHoliday:
      (json['regularHoliday'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  tellNumber: json['tellNumber'] as String,
  address: json['address'] as String,
  seats: (json['seats'] as num).toInt(),
  parking: (json['parking'] as num).toInt(),
  price: json['price'] as String?,
  description: json['description'] as String,
);

Map<String, dynamic> _$StoreModelToJson(_StoreModel instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'storeName': instance.storeName,
      'imagePath': instance.imagePath,
      'openingHours': instance.openingHours,
      'regularHoliday': instance.regularHoliday,
      'tellNumber': instance.tellNumber,
      'address': instance.address,
      'seats': instance.seats,
      'parking': instance.parking,
      'price': instance.price,
      'description': instance.description,
    };
