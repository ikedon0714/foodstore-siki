// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CouponModel {

// ドキュメントID
 String get couponId;// Firestore timestamps
@TimestampConverter() Timestamp get createdAt;@TimestampConverter() Timestamp get updatedAt;// 基本情報
 String get couponName; String get couponType;// 設計図どおり
 String? get description; String get imagePath;// 利用可能店舗
 List<String> get storeIds;// 期限
@TimestampConverter() Timestamp get deadlineStart;@TimestampConverter() Timestamp get deadlineEnd;
/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponModelCopyWith<CouponModel> get copyWith => _$CouponModelCopyWithImpl<CouponModel>(this as CouponModel, _$identity);

  /// Serializes this CouponModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponModel&&(identical(other.couponId, couponId) || other.couponId == couponId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.couponName, couponName) || other.couponName == couponName)&&(identical(other.couponType, couponType) || other.couponType == couponType)&&(identical(other.description, description) || other.description == description)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.storeIds, storeIds)&&(identical(other.deadlineStart, deadlineStart) || other.deadlineStart == deadlineStart)&&(identical(other.deadlineEnd, deadlineEnd) || other.deadlineEnd == deadlineEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponId,createdAt,updatedAt,couponName,couponType,description,imagePath,const DeepCollectionEquality().hash(storeIds),deadlineStart,deadlineEnd);

@override
String toString() {
  return 'CouponModel(couponId: $couponId, createdAt: $createdAt, updatedAt: $updatedAt, couponName: $couponName, couponType: $couponType, description: $description, imagePath: $imagePath, storeIds: $storeIds, deadlineStart: $deadlineStart, deadlineEnd: $deadlineEnd)';
}


}

/// @nodoc
abstract mixin class $CouponModelCopyWith<$Res>  {
  factory $CouponModelCopyWith(CouponModel value, $Res Function(CouponModel) _then) = _$CouponModelCopyWithImpl;
@useResult
$Res call({
 String couponId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String couponName, String couponType, String? description, String imagePath, List<String> storeIds,@TimestampConverter() Timestamp deadlineStart,@TimestampConverter() Timestamp deadlineEnd
});




}
/// @nodoc
class _$CouponModelCopyWithImpl<$Res>
    implements $CouponModelCopyWith<$Res> {
  _$CouponModelCopyWithImpl(this._self, this._then);

  final CouponModel _self;
  final $Res Function(CouponModel) _then;

/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? couponId = null,Object? createdAt = null,Object? updatedAt = null,Object? couponName = null,Object? couponType = null,Object? description = freezed,Object? imagePath = null,Object? storeIds = null,Object? deadlineStart = null,Object? deadlineEnd = null,}) {
  return _then(_self.copyWith(
couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,couponName: null == couponName ? _self.couponName : couponName // ignore: cast_nullable_to_non_nullable
as String,couponType: null == couponType ? _self.couponType : couponType // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,storeIds: null == storeIds ? _self.storeIds : storeIds // ignore: cast_nullable_to_non_nullable
as List<String>,deadlineStart: null == deadlineStart ? _self.deadlineStart : deadlineStart // ignore: cast_nullable_to_non_nullable
as Timestamp,deadlineEnd: null == deadlineEnd ? _self.deadlineEnd : deadlineEnd // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}

}


/// Adds pattern-matching-related methods to [CouponModel].
extension CouponModelPatterns on CouponModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponModel value)  $default,){
final _that = this;
switch (_that) {
case _CouponModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponModel value)?  $default,){
final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String couponId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String couponName,  String couponType,  String? description,  String imagePath,  List<String> storeIds, @TimestampConverter()  Timestamp deadlineStart, @TimestampConverter()  Timestamp deadlineEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
return $default(_that.couponId,_that.createdAt,_that.updatedAt,_that.couponName,_that.couponType,_that.description,_that.imagePath,_that.storeIds,_that.deadlineStart,_that.deadlineEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String couponId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String couponName,  String couponType,  String? description,  String imagePath,  List<String> storeIds, @TimestampConverter()  Timestamp deadlineStart, @TimestampConverter()  Timestamp deadlineEnd)  $default,) {final _that = this;
switch (_that) {
case _CouponModel():
return $default(_that.couponId,_that.createdAt,_that.updatedAt,_that.couponName,_that.couponType,_that.description,_that.imagePath,_that.storeIds,_that.deadlineStart,_that.deadlineEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String couponId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String couponName,  String couponType,  String? description,  String imagePath,  List<String> storeIds, @TimestampConverter()  Timestamp deadlineStart, @TimestampConverter()  Timestamp deadlineEnd)?  $default,) {final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
return $default(_that.couponId,_that.createdAt,_that.updatedAt,_that.couponName,_that.couponType,_that.description,_that.imagePath,_that.storeIds,_that.deadlineStart,_that.deadlineEnd);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _CouponModel implements CouponModel {
  const _CouponModel({required this.couponId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.couponName, required this.couponType, this.description, required this.imagePath, final  List<String> storeIds = const <String>[], @TimestampConverter() required this.deadlineStart, @TimestampConverter() required this.deadlineEnd}): _storeIds = storeIds;
  factory _CouponModel.fromJson(Map<String, dynamic> json) => _$CouponModelFromJson(json);

// ドキュメントID
@override final  String couponId;
// Firestore timestamps
@override@TimestampConverter() final  Timestamp createdAt;
@override@TimestampConverter() final  Timestamp updatedAt;
// 基本情報
@override final  String couponName;
@override final  String couponType;
// 設計図どおり
@override final  String? description;
@override final  String imagePath;
// 利用可能店舗
 final  List<String> _storeIds;
// 利用可能店舗
@override@JsonKey() List<String> get storeIds {
  if (_storeIds is EqualUnmodifiableListView) return _storeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storeIds);
}

// 期限
@override@TimestampConverter() final  Timestamp deadlineStart;
@override@TimestampConverter() final  Timestamp deadlineEnd;

/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponModelCopyWith<_CouponModel> get copyWith => __$CouponModelCopyWithImpl<_CouponModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponModel&&(identical(other.couponId, couponId) || other.couponId == couponId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.couponName, couponName) || other.couponName == couponName)&&(identical(other.couponType, couponType) || other.couponType == couponType)&&(identical(other.description, description) || other.description == description)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other._storeIds, _storeIds)&&(identical(other.deadlineStart, deadlineStart) || other.deadlineStart == deadlineStart)&&(identical(other.deadlineEnd, deadlineEnd) || other.deadlineEnd == deadlineEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponId,createdAt,updatedAt,couponName,couponType,description,imagePath,const DeepCollectionEquality().hash(_storeIds),deadlineStart,deadlineEnd);

@override
String toString() {
  return 'CouponModel(couponId: $couponId, createdAt: $createdAt, updatedAt: $updatedAt, couponName: $couponName, couponType: $couponType, description: $description, imagePath: $imagePath, storeIds: $storeIds, deadlineStart: $deadlineStart, deadlineEnd: $deadlineEnd)';
}


}

/// @nodoc
abstract mixin class _$CouponModelCopyWith<$Res> implements $CouponModelCopyWith<$Res> {
  factory _$CouponModelCopyWith(_CouponModel value, $Res Function(_CouponModel) _then) = __$CouponModelCopyWithImpl;
@override @useResult
$Res call({
 String couponId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String couponName, String couponType, String? description, String imagePath, List<String> storeIds,@TimestampConverter() Timestamp deadlineStart,@TimestampConverter() Timestamp deadlineEnd
});




}
/// @nodoc
class __$CouponModelCopyWithImpl<$Res>
    implements _$CouponModelCopyWith<$Res> {
  __$CouponModelCopyWithImpl(this._self, this._then);

  final _CouponModel _self;
  final $Res Function(_CouponModel) _then;

/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? couponId = null,Object? createdAt = null,Object? updatedAt = null,Object? couponName = null,Object? couponType = null,Object? description = freezed,Object? imagePath = null,Object? storeIds = null,Object? deadlineStart = null,Object? deadlineEnd = null,}) {
  return _then(_CouponModel(
couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,couponName: null == couponName ? _self.couponName : couponName // ignore: cast_nullable_to_non_nullable
as String,couponType: null == couponType ? _self.couponType : couponType // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,storeIds: null == storeIds ? _self._storeIds : storeIds // ignore: cast_nullable_to_non_nullable
as List<String>,deadlineStart: null == deadlineStart ? _self.deadlineStart : deadlineStart // ignore: cast_nullable_to_non_nullable
as Timestamp,deadlineEnd: null == deadlineEnd ? _self.deadlineEnd : deadlineEnd // ignore: cast_nullable_to_non_nullable
as Timestamp,
  ));
}


}

// dart format on
