import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Firestore Timestamp を json_serializable で扱うための Converter（non-null）
class TimestampConverter implements JsonConverter<Timestamp, Object?> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Object? json) {
    if (json is Timestamp) return json;
    if (json is DateTime) return Timestamp.fromDate(json);
    if (json is int) return Timestamp.fromMillisecondsSinceEpoch(json); // millis
    if (json is String) return Timestamp.fromDate(DateTime.parse(json)); // ISO8601
    throw ArgumentError('TimestampConverter: unsupported type: ${json.runtimeType}');
  }

  @override
  Object? toJson(Timestamp object) => object;
}

/// Firestore Timestamp を json_serializable で扱うための Converter（nullable）
class NullableTimestampConverter implements JsonConverter<Timestamp?, Object?> {
  const NullableTimestampConverter();

  @override
  Timestamp? fromJson(Object? json) {
    if (json == null) return null;
    return const TimestampConverter().fromJson(json);
  }

  @override
  Object? toJson(Timestamp? object) => object;
}
