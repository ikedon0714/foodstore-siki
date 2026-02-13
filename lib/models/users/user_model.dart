import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';
import 'user_role.dart';
import 'user_rank.dart';
import 'gender.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  @JsonSerializable(anyMap: true, explicitToJson: true)
  const factory UserModel({
    // ドキュメントID (fromFirestoreで注入)
    required String uid,

    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,

    required String userName,
    String? imagePath,

    @NullableTimestampConverter() Timestamp? birthday,

    // String? から Enum型へ変更
    @Default(Gender.unknown) Gender gender,

    @Default(<String>[]) List<String> favoriteStore,
    String? downloadStore,

    // String から Enum型へ変更
    @Default(UserRank.regular) UserRank userRank,

    @Default(0) int totalPoints,

    @NullableTimestampConverter() Timestamp? lastFailedAt,
    @Default(0) int failedCount,

    // String から Enum型へ変更
    @Default(UserRole.normal) UserRole userRole,
  }) = _UserModel;

  bool get isAdmin => userRole == UserRole.admin;

  factory UserModel.initial({
    required String uid,
  }) {
    final now = Timestamp.now();
    return UserModel(
      uid: uid,
      createdAt: now,
      updatedAt: now,
      userName: '', // or ''
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('UserModel.fromFirestore: data is null (id: ${doc.id})');
    }
    return UserModel.fromJson({
      ...data as Map<String, dynamic>,
      'uid': doc.id,
    });
  }

  static Map<String, dynamic> toFirestore(UserModel user) =>
      user.toJson()..remove('uid');
}