// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreModel {

// ドキュメントID
 String get storeId;// Firestore timestamps
@TimestampConverter() Timestamp get createdAt;@TimestampConverter() Timestamp get updatedAt;// 基本情報
 String get storeName; String get imagePath;// 営業情報
 String get openingHours;// businessHours -> openingHours
 List<String> get regularHoliday;// businessHoliday -> regularHoliday
// 連絡先
 String get tellNumber;// tel -> tellNumber
 String get address;// 追加フィールド（設計図どおり）
 int get seats; int get parking; String? get price; String get description;
/// Create a copy of StoreModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreModelCopyWith<StoreModel> get copyWith => _$StoreModelCopyWithImpl<StoreModel>(this as StoreModel, _$identity);

  /// Serializes this StoreModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreModel&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&const DeepCollectionEquality().equals(other.regularHoliday, regularHoliday)&&(identical(other.tellNumber, tellNumber) || other.tellNumber == tellNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.parking, parking) || other.parking == parking)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storeId,createdAt,updatedAt,storeName,imagePath,openingHours,const DeepCollectionEquality().hash(regularHoliday),tellNumber,address,seats,parking,price,description);

@override
String toString() {
  return 'StoreModel(storeId: $storeId, createdAt: $createdAt, updatedAt: $updatedAt, storeName: $storeName, imagePath: $imagePath, openingHours: $openingHours, regularHoliday: $regularHoliday, tellNumber: $tellNumber, address: $address, seats: $seats, parking: $parking, price: $price, description: $description)';
}


}

/// @nodoc
abstract mixin class $StoreModelCopyWith<$Res>  {
  factory $StoreModelCopyWith(StoreModel value, $Res Function(StoreModel) _then) = _$StoreModelCopyWithImpl;
@useResult
$Res call({
 String storeId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String storeName, String imagePath, String openingHours, List<String> regularHoliday, String tellNumber, String address, int seats, int parking, String? price, String description
});




}
/// @nodoc
class _$StoreModelCopyWithImpl<$Res>
    implements $StoreModelCopyWith<$Res> {
  _$StoreModelCopyWithImpl(this._self, this._then);

  final StoreModel _self;
  final $Res Function(StoreModel) _then;

/// Create a copy of StoreModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storeId = null,Object? createdAt = null,Object? updatedAt = null,Object? storeName = null,Object? imagePath = null,Object? openingHours = null,Object? regularHoliday = null,Object? tellNumber = null,Object? address = null,Object? seats = null,Object? parking = null,Object? price = freezed,Object? description = null,}) {
  return _then(_self.copyWith(
storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String,regularHoliday: null == regularHoliday ? _self.regularHoliday : regularHoliday // ignore: cast_nullable_to_non_nullable
as List<String>,tellNumber: null == tellNumber ? _self.tellNumber : tellNumber // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,parking: null == parking ? _self.parking : parking // ignore: cast_nullable_to_non_nullable
as int,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreModel].
extension StoreModelPatterns on StoreModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreModel value)  $default,){
final _that = this;
switch (_that) {
case _StoreModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoreModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String storeId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String storeName,  String imagePath,  String openingHours,  List<String> regularHoliday,  String tellNumber,  String address,  int seats,  int parking,  String? price,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreModel() when $default != null:
return $default(_that.storeId,_that.createdAt,_that.updatedAt,_that.storeName,_that.imagePath,_that.openingHours,_that.regularHoliday,_that.tellNumber,_that.address,_that.seats,_that.parking,_that.price,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String storeId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String storeName,  String imagePath,  String openingHours,  List<String> regularHoliday,  String tellNumber,  String address,  int seats,  int parking,  String? price,  String description)  $default,) {final _that = this;
switch (_that) {
case _StoreModel():
return $default(_that.storeId,_that.createdAt,_that.updatedAt,_that.storeName,_that.imagePath,_that.openingHours,_that.regularHoliday,_that.tellNumber,_that.address,_that.seats,_that.parking,_that.price,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String storeId, @TimestampConverter()  Timestamp createdAt, @TimestampConverter()  Timestamp updatedAt,  String storeName,  String imagePath,  String openingHours,  List<String> regularHoliday,  String tellNumber,  String address,  int seats,  int parking,  String? price,  String description)?  $default,) {final _that = this;
switch (_that) {
case _StoreModel() when $default != null:
return $default(_that.storeId,_that.createdAt,_that.updatedAt,_that.storeName,_that.imagePath,_that.openingHours,_that.regularHoliday,_that.tellNumber,_that.address,_that.seats,_that.parking,_that.price,_that.description);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(anyMap: true, explicitToJson: true)
class _StoreModel implements StoreModel {
  const _StoreModel({required this.storeId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.storeName, required this.imagePath, required this.openingHours, final  List<String> regularHoliday = const <String>[], required this.tellNumber, required this.address, required this.seats, required this.parking, this.price, required this.description}): _regularHoliday = regularHoliday;
  factory _StoreModel.fromJson(Map<String, dynamic> json) => _$StoreModelFromJson(json);

// ドキュメントID
@override final  String storeId;
// Firestore timestamps
@override@TimestampConverter() final  Timestamp createdAt;
@override@TimestampConverter() final  Timestamp updatedAt;
// 基本情報
@override final  String storeName;
@override final  String imagePath;
// 営業情報
@override final  String openingHours;
// businessHours -> openingHours
 final  List<String> _regularHoliday;
// businessHours -> openingHours
@override@JsonKey() List<String> get regularHoliday {
  if (_regularHoliday is EqualUnmodifiableListView) return _regularHoliday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regularHoliday);
}

// businessHoliday -> regularHoliday
// 連絡先
@override final  String tellNumber;
// tel -> tellNumber
@override final  String address;
// 追加フィールド（設計図どおり）
@override final  int seats;
@override final  int parking;
@override final  String? price;
@override final  String description;

/// Create a copy of StoreModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreModelCopyWith<_StoreModel> get copyWith => __$StoreModelCopyWithImpl<_StoreModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreModel&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&const DeepCollectionEquality().equals(other._regularHoliday, _regularHoliday)&&(identical(other.tellNumber, tellNumber) || other.tellNumber == tellNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.parking, parking) || other.parking == parking)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storeId,createdAt,updatedAt,storeName,imagePath,openingHours,const DeepCollectionEquality().hash(_regularHoliday),tellNumber,address,seats,parking,price,description);

@override
String toString() {
  return 'StoreModel(storeId: $storeId, createdAt: $createdAt, updatedAt: $updatedAt, storeName: $storeName, imagePath: $imagePath, openingHours: $openingHours, regularHoliday: $regularHoliday, tellNumber: $tellNumber, address: $address, seats: $seats, parking: $parking, price: $price, description: $description)';
}


}

/// @nodoc
abstract mixin class _$StoreModelCopyWith<$Res> implements $StoreModelCopyWith<$Res> {
  factory _$StoreModelCopyWith(_StoreModel value, $Res Function(_StoreModel) _then) = __$StoreModelCopyWithImpl;
@override @useResult
$Res call({
 String storeId,@TimestampConverter() Timestamp createdAt,@TimestampConverter() Timestamp updatedAt, String storeName, String imagePath, String openingHours, List<String> regularHoliday, String tellNumber, String address, int seats, int parking, String? price, String description
});




}
/// @nodoc
class __$StoreModelCopyWithImpl<$Res>
    implements _$StoreModelCopyWith<$Res> {
  __$StoreModelCopyWithImpl(this._self, this._then);

  final _StoreModel _self;
  final $Res Function(_StoreModel) _then;

/// Create a copy of StoreModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storeId = null,Object? createdAt = null,Object? updatedAt = null,Object? storeName = null,Object? imagePath = null,Object? openingHours = null,Object? regularHoliday = null,Object? tellNumber = null,Object? address = null,Object? seats = null,Object? parking = null,Object? price = freezed,Object? description = null,}) {
  return _then(_StoreModel(
storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as Timestamp,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as Timestamp,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String,regularHoliday: null == regularHoliday ? _self._regularHoliday : regularHoliday // ignore: cast_nullable_to_non_nullable
as List<String>,tellNumber: null == tellNumber ? _self.tellNumber : tellNumber // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,parking: null == parking ? _self.parking : parking // ignore: cast_nullable_to_non_nullable
as int,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
