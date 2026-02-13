// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StampModel {

// ドキュメントIDの保持
 String get stampId;// 設計図どおり
@TimestampConverter() Timestamp get createdAt;@TimestampConverter() Timestamp get updatedAt; String get storeId;// デフォルト値（設計図: points）
 int get points;
/// Create a copy of StampModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StampModelCopyWith<StampModel> get copyWith => _$StampModelCopyWithImpl<StampModel>(this as StampModel, _$identity);

  /// Serializes this StampModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StampModel&&(identical(other.stampId, stampId) || other.stampId == stampId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stampId,createdAt,updatedAt,storeId,points);

@override
String toString() {
  return 'StampModel(stampId: $stampId, createdAt: $createdAt, updatedAt: $updatedAt, storeId: $storeId, points: $points)';
}


}

/// @nodoc
abstract mixin class $StampModelCopyWith<$Res>  {
  factory $StampModelCopyWith(StampModel value, $Res Function(StampModel) _then) = _$StampModelCopyWithImpl;
@useResult
$Res call({
 String stampId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String storeId, int points
});




}
/// @nodoc
class _$StampModelCopyWithImpl<$Res>
    implements $StampModelCopyWith<$Res> {
  _$StampModelCopyWithImpl(this._self, this._then);

  final StampModel _self;
  final $Res Function(StampModel) _then;

/// Create a copy of StampModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stampId = null,Object? createdAt = null,Object? updatedAt = null,Object? storeId = null,Object? points = null,}) {
  return _then(_self.copyWith(
stampId: null == stampId ? _self.stampId : stampId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StampModel].
extension StampModelPatterns on StampModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StampModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StampModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StampModel value)  $default,){
final _that = this;
switch (_that) {
case _StampModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StampModel value)?  $default,){
final _that = this;
switch (_that) {
case _StampModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stampId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String storeId,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StampModel() when $default != null:
return $default(_that.stampId,_that.createdAt,_that.updatedAt,_that.storeId,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stampId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String storeId,  int points)  $default,) {final _that = this;
switch (_that) {
case _StampModel():
return $default(_that.stampId,_that.createdAt,_that.updatedAt,_that.storeId,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stampId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String storeId,  int points)?  $default,) {final _that = this;
switch (_that) {
case _StampModel() when $default != null:
return $default(_that.stampId,_that.createdAt,_that.updatedAt,_that.storeId,_that.points);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _StampModel implements StampModel {
  const _StampModel({required this.stampId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.storeId, this.points = 1});
  factory _StampModel.fromJson(Map<String, dynamic> json) => _$StampModelFromJson(json);

// ドキュメントIDの保持
@override final  String stampId;
// 設計図どおり
@override@TimestampConverter() final  Timestamp createdAt;
@override@TimestampConverter() final  Timestamp updatedAt;
@override final  String storeId;
// デフォルト値（設計図: points）
@override@JsonKey() final  int points;

/// Create a copy of StampModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StampModelCopyWith<_StampModel> get copyWith => __$StampModelCopyWithImpl<_StampModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StampModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StampModel&&(identical(other.stampId, stampId) || other.stampId == stampId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stampId,createdAt,updatedAt,storeId,points);

@override
String toString() {
  return 'StampModel(stampId: $stampId, createdAt: $createdAt, updatedAt: $updatedAt, storeId: $storeId, points: $points)';
}


}

/// @nodoc
abstract mixin class _$StampModelCopyWith<$Res> implements $StampModelCopyWith<$Res> {
  factory _$StampModelCopyWith(_StampModel value, $Res Function(_StampModel) _then) = __$StampModelCopyWithImpl;
@override @useResult
$Res call({
 String stampId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String storeId, int points
});




}
/// @nodoc
class __$StampModelCopyWithImpl<$Res>
    implements _$StampModelCopyWith<$Res> {
  __$StampModelCopyWithImpl(this._self, this._then);

  final _StampModel _self;
  final $Res Function(_StampModel) _then;

/// Create a copy of StampModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stampId = null,Object? createdAt = null,Object? updatedAt = null,Object? storeId = null,Object? points = null,}) {
  return _then(_StampModel(
stampId: null == stampId ? _self.stampId : stampId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
