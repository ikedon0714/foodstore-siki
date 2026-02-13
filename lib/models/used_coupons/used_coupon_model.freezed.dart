// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'used_coupon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsedCouponModel {

// ドキュメントID（サブコレクション側のdoc.id）
 String get usedCouponId;// 設計図どおり
@TimestampConverter() Timestamp get createdAt;@TimestampConverter() Timestamp get updatedAt; String get couponId;
/// Create a copy of UsedCouponModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsedCouponModelCopyWith<UsedCouponModel> get copyWith => _$UsedCouponModelCopyWithImpl<UsedCouponModel>(this as UsedCouponModel, _$identity);

  /// Serializes this UsedCouponModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsedCouponModel&&(identical(other.usedCouponId, usedCouponId) || other.usedCouponId == usedCouponId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.couponId, couponId) || other.couponId == couponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usedCouponId,createdAt,updatedAt,couponId);

@override
String toString() {
  return 'UsedCouponModel(usedCouponId: $usedCouponId, createdAt: $createdAt, updatedAt: $updatedAt, couponId: $couponId)';
}


}

/// @nodoc
abstract mixin class $UsedCouponModelCopyWith<$Res>  {
  factory $UsedCouponModelCopyWith(UsedCouponModel value, $Res Function(UsedCouponModel) _then) = _$UsedCouponModelCopyWithImpl;
@useResult
$Res call({
 String usedCouponId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String couponId
});




}
/// @nodoc
class _$UsedCouponModelCopyWithImpl<$Res>
    implements $UsedCouponModelCopyWith<$Res> {
  _$UsedCouponModelCopyWithImpl(this._self, this._then);

  final UsedCouponModel _self;
  final $Res Function(UsedCouponModel) _then;

/// Create a copy of UsedCouponModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? usedCouponId = null,Object? createdAt = null,Object? updatedAt = null,Object? couponId = null,}) {
  return _then(_self.copyWith(
usedCouponId: null == usedCouponId ? _self.usedCouponId : usedCouponId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UsedCouponModel].
extension UsedCouponModelPatterns on UsedCouponModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsedCouponModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsedCouponModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsedCouponModel value)  $default,){
final _that = this;
switch (_that) {
case _UsedCouponModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsedCouponModel value)?  $default,){
final _that = this;
switch (_that) {
case _UsedCouponModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String usedCouponId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String couponId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsedCouponModel() when $default != null:
return $default(_that.usedCouponId,_that.createdAt,_that.updatedAt,_that.couponId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String usedCouponId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String couponId)  $default,) {final _that = this;
switch (_that) {
case _UsedCouponModel():
return $default(_that.usedCouponId,_that.createdAt,_that.updatedAt,_that.couponId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String usedCouponId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String couponId)?  $default,) {final _that = this;
switch (_that) {
case _UsedCouponModel() when $default != null:
return $default(_that.usedCouponId,_that.createdAt,_that.updatedAt,_that.couponId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _UsedCouponModel implements UsedCouponModel {
  const _UsedCouponModel({required this.usedCouponId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.couponId});
  factory _UsedCouponModel.fromJson(Map<String, dynamic> json) => _$UsedCouponModelFromJson(json);

// ドキュメントID（サブコレクション側のdoc.id）
@override final  String usedCouponId;
// 設計図どおり
@override@TimestampConverter() final  Timestamp createdAt;
@override@TimestampConverter() final  Timestamp updatedAt;
@override final  String couponId;

/// Create a copy of UsedCouponModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsedCouponModelCopyWith<_UsedCouponModel> get copyWith => __$UsedCouponModelCopyWithImpl<_UsedCouponModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsedCouponModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsedCouponModel&&(identical(other.usedCouponId, usedCouponId) || other.usedCouponId == usedCouponId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.couponId, couponId) || other.couponId == couponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,usedCouponId,createdAt,updatedAt,couponId);

@override
String toString() {
  return 'UsedCouponModel(usedCouponId: $usedCouponId, createdAt: $createdAt, updatedAt: $updatedAt, couponId: $couponId)';
}


}

/// @nodoc
abstract mixin class _$UsedCouponModelCopyWith<$Res> implements $UsedCouponModelCopyWith<$Res> {
  factory _$UsedCouponModelCopyWith(_UsedCouponModel value, $Res Function(_UsedCouponModel) _then) = __$UsedCouponModelCopyWithImpl;
@override @useResult
$Res call({
 String usedCouponId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String couponId
});




}
/// @nodoc
class __$UsedCouponModelCopyWithImpl<$Res>
    implements _$UsedCouponModelCopyWith<$Res> {
  __$UsedCouponModelCopyWithImpl(this._self, this._then);

  final _UsedCouponModel _self;
  final $Res Function(_UsedCouponModel) _then;

/// Create a copy of UsedCouponModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? usedCouponId = null,Object? createdAt = null,Object? updatedAt = null,Object? couponId = null,}) {
  return _then(_UsedCouponModel(
usedCouponId: null == usedCouponId ? _self.usedCouponId : usedCouponId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
