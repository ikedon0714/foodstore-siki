// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

// ドキュメントID (fromFirestoreで注入)
 String get uid;@TimestampConverter() Timestamp get createdAt;@TimestampConverter() Timestamp get updatedAt; String get userName; String? get imagePath;@NullableTimestampConverter() Timestamp? get birthday;// String? から Enum型へ変更
 Gender get gender; List<String> get favoriteStore; String? get downloadStore;// String から Enum型へ変更
 UserRank get userRank; int get totalPoints;@NullableTimestampConverter() Timestamp? get lastFailedAt; int get failedCount;// String から Enum型へ変更
 UserRole get userRole;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other.favoriteStore, favoriteStore)&&(identical(other.downloadStore, downloadStore) || other.downloadStore == downloadStore)&&(identical(other.userRank, userRank) || other.userRank == userRank)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.lastFailedAt, lastFailedAt) || other.lastFailedAt == lastFailedAt)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.userRole, userRole) || other.userRole == userRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,createdAt,updatedAt,userName,imagePath,birthday,gender,const DeepCollectionEquality().hash(favoriteStore),downloadStore,userRank,totalPoints,lastFailedAt,failedCount,userRole);

@override
String toString() {
  return 'UserModel(uid: $uid, createdAt: $createdAt, updatedAt: $updatedAt, userName: $userName, imagePath: $imagePath, birthday: $birthday, gender: $gender, favoriteStore: $favoriteStore, downloadStore: $downloadStore, userRank: $userRank, totalPoints: $totalPoints, lastFailedAt: $lastFailedAt, failedCount: $failedCount, userRole: $userRole)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String uid,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String userName, String? imagePath,@NullableTimestampConverter() Timestamp? birthday, Gender gender, List<String> favoriteStore, String? downloadStore, UserRank userRank, int totalPoints,@NullableTimestampConverter() Timestamp? lastFailedAt, int failedCount, UserRole userRole
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? createdAt = null,Object? updatedAt = null,Object? userName = null,Object? imagePath = freezed,Object? birthday = freezed,Object? gender = null,Object? favoriteStore = null,Object? downloadStore = freezed,Object? userRank = null,Object? totalPoints = null,Object? lastFailedAt = freezed,Object? failedCount = null,Object? userRole = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as Timestamp?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,favoriteStore: null == favoriteStore ? _self.favoriteStore : favoriteStore // ignore: cast_nullable_to_non_nullable
as List<String>,downloadStore: freezed == downloadStore ? _self.downloadStore : downloadStore // ignore: cast_nullable_to_non_nullable
as String?,userRank: null == userRank ? _self.userRank : userRank // ignore: cast_nullable_to_non_nullable
as UserRank,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,lastFailedAt: freezed == lastFailedAt ? _self.lastFailedAt : lastFailedAt // ignore: cast_nullable_to_non_nullable
as Timestamp?,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String userName,  String? imagePath, @NullableTimestampConverter()  Timestamp? birthday,  Gender gender,  List<String> favoriteStore,  String? downloadStore,  UserRank userRank,  int totalPoints, @NullableTimestampConverter()  Timestamp? lastFailedAt,  int failedCount,  UserRole userRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.createdAt,_that.updatedAt,_that.userName,_that.imagePath,_that.birthday,_that.gender,_that.favoriteStore,_that.downloadStore,_that.userRank,_that.totalPoints,_that.lastFailedAt,_that.failedCount,_that.userRole);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String userName,  String? imagePath, @NullableTimestampConverter()  Timestamp? birthday,  Gender gender,  List<String> favoriteStore,  String? downloadStore,  UserRank userRank,  int totalPoints, @NullableTimestampConverter()  Timestamp? lastFailedAt,  int failedCount,  UserRole userRole)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.uid,_that.createdAt,_that.updatedAt,_that.userName,_that.imagePath,_that.birthday,_that.gender,_that.favoriteStore,_that.downloadStore,_that.userRank,_that.totalPoints,_that.lastFailedAt,_that.failedCount,_that.userRole);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String userName,  String? imagePath, @NullableTimestampConverter()  Timestamp? birthday,  Gender gender,  List<String> favoriteStore,  String? downloadStore,  UserRank userRank,  int totalPoints, @NullableTimestampConverter()  Timestamp? lastFailedAt,  int failedCount,  UserRole userRole)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.createdAt,_that.updatedAt,_that.userName,_that.imagePath,_that.birthday,_that.gender,_that.favoriteStore,_that.downloadStore,_that.userRank,_that.totalPoints,_that.lastFailedAt,_that.failedCount,_that.userRole);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _UserModel extends UserModel {
  const _UserModel({required this.uid, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.userName, this.imagePath, @NullableTimestampConverter() this.birthday, this.gender = Gender.unknown, final  List<String> favoriteStore = const <String>[], this.downloadStore, this.userRank = UserRank.regular, this.totalPoints = 0, @NullableTimestampConverter() this.lastFailedAt, this.failedCount = 0, this.userRole = UserRole.normal}): _favoriteStore = favoriteStore,super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

// ドキュメントID (fromFirestoreで注入)
@override final  String uid;
@override@TimestampConverter() final  Timestamp createdAt;
@override@TimestampConverter() final  Timestamp updatedAt;
@override final  String userName;
@override final  String? imagePath;
@override@NullableTimestampConverter() final  Timestamp? birthday;
// String? から Enum型へ変更
@override@JsonKey() final  Gender gender;
 final  List<String> _favoriteStore;
@override@JsonKey() List<String> get favoriteStore {
  if (_favoriteStore is EqualUnmodifiableListView) return _favoriteStore;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteStore);
}

@override final  String? downloadStore;
// String から Enum型へ変更
@override@JsonKey() final  UserRank userRank;
@override@JsonKey() final  int totalPoints;
@override@NullableTimestampConverter() final  Timestamp? lastFailedAt;
@override@JsonKey() final  int failedCount;
// String から Enum型へ変更
@override@JsonKey() final  UserRole userRole;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other._favoriteStore, _favoriteStore)&&(identical(other.downloadStore, downloadStore) || other.downloadStore == downloadStore)&&(identical(other.userRank, userRank) || other.userRank == userRank)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.lastFailedAt, lastFailedAt) || other.lastFailedAt == lastFailedAt)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&(identical(other.userRole, userRole) || other.userRole == userRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,createdAt,updatedAt,userName,imagePath,birthday,gender,const DeepCollectionEquality().hash(_favoriteStore),downloadStore,userRank,totalPoints,lastFailedAt,failedCount,userRole);

@override
String toString() {
  return 'UserModel(uid: $uid, createdAt: $createdAt, updatedAt: $updatedAt, userName: $userName, imagePath: $imagePath, birthday: $birthday, gender: $gender, favoriteStore: $favoriteStore, downloadStore: $downloadStore, userRank: $userRank, totalPoints: $totalPoints, lastFailedAt: $lastFailedAt, failedCount: $failedCount, userRole: $userRole)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String uid,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String userName, String? imagePath,@NullableTimestampConverter() Timestamp? birthday, Gender gender, List<String> favoriteStore, String? downloadStore, UserRank userRank, int totalPoints,@NullableTimestampConverter() Timestamp? lastFailedAt, int failedCount, UserRole userRole
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? createdAt = null,Object? updatedAt = null,Object? userName = null,Object? imagePath = freezed,Object? birthday = freezed,Object? gender = null,Object? favoriteStore = null,Object? downloadStore = freezed,Object? userRank = null,Object? totalPoints = null,Object? lastFailedAt = freezed,Object? failedCount = null,Object? userRole = null,}) {
  return _then(_UserModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as Timestamp?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,favoriteStore: null == favoriteStore ? _self._favoriteStore : favoriteStore // ignore: cast_nullable_to_non_nullable
as List<String>,downloadStore: freezed == downloadStore ? _self.downloadStore : downloadStore // ignore: cast_nullable_to_non_nullable
as String?,userRank: null == userRank ? _self.userRank : userRank // ignore: cast_nullable_to_non_nullable
as UserRank,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,lastFailedAt: freezed == lastFailedAt ? _self.lastFailedAt : lastFailedAt // ignore: cast_nullable_to_non_nullable
as Timestamp?,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

// dart format on
