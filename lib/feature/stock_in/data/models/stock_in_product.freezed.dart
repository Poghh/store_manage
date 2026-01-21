// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_in_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockInProduct {

 String get productCode; String get productName; String? get unit;
/// Create a copy of StockInProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockInProductCopyWith<StockInProduct> get copyWith => _$StockInProductCopyWithImpl<StockInProduct>(this as StockInProduct, _$identity);

  /// Serializes this StockInProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockInProduct&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productCode,productName,unit);

@override
String toString() {
  return 'StockInProduct(productCode: $productCode, productName: $productName, unit: $unit)';
}


}

/// @nodoc
abstract mixin class $StockInProductCopyWith<$Res>  {
  factory $StockInProductCopyWith(StockInProduct value, $Res Function(StockInProduct) _then) = _$StockInProductCopyWithImpl;
@useResult
$Res call({
 String productCode, String productName, String? unit
});




}
/// @nodoc
class _$StockInProductCopyWithImpl<$Res>
    implements $StockInProductCopyWith<$Res> {
  _$StockInProductCopyWithImpl(this._self, this._then);

  final StockInProduct _self;
  final $Res Function(StockInProduct) _then;

/// Create a copy of StockInProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productCode = null,Object? productName = null,Object? unit = freezed,}) {
  return _then(_self.copyWith(
productCode: null == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockInProduct].
extension StockInProductPatterns on StockInProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockInProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockInProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockInProduct value)  $default,){
final _that = this;
switch (_that) {
case _StockInProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockInProduct value)?  $default,){
final _that = this;
switch (_that) {
case _StockInProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productCode,  String productName,  String? unit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockInProduct() when $default != null:
return $default(_that.productCode,_that.productName,_that.unit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productCode,  String productName,  String? unit)  $default,) {final _that = this;
switch (_that) {
case _StockInProduct():
return $default(_that.productCode,_that.productName,_that.unit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productCode,  String productName,  String? unit)?  $default,) {final _that = this;
switch (_that) {
case _StockInProduct() when $default != null:
return $default(_that.productCode,_that.productName,_that.unit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockInProduct implements StockInProduct {
  const _StockInProduct({required this.productCode, required this.productName, this.unit});
  factory _StockInProduct.fromJson(Map<String, dynamic> json) => _$StockInProductFromJson(json);

@override final  String productCode;
@override final  String productName;
@override final  String? unit;

/// Create a copy of StockInProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockInProductCopyWith<_StockInProduct> get copyWith => __$StockInProductCopyWithImpl<_StockInProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockInProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockInProduct&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.unit, unit) || other.unit == unit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productCode,productName,unit);

@override
String toString() {
  return 'StockInProduct(productCode: $productCode, productName: $productName, unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$StockInProductCopyWith<$Res> implements $StockInProductCopyWith<$Res> {
  factory _$StockInProductCopyWith(_StockInProduct value, $Res Function(_StockInProduct) _then) = __$StockInProductCopyWithImpl;
@override @useResult
$Res call({
 String productCode, String productName, String? unit
});




}
/// @nodoc
class __$StockInProductCopyWithImpl<$Res>
    implements _$StockInProductCopyWith<$Res> {
  __$StockInProductCopyWithImpl(this._self, this._then);

  final _StockInProduct _self;
  final $Res Function(_StockInProduct) _then;

/// Create a copy of StockInProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productCode = null,Object? productName = null,Object? unit = freezed,}) {
  return _then(_StockInProduct(
productCode: null == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
