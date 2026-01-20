// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommonResponseModel<T> {

 int get status; T get data;
/// Create a copy of CommonResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonResponseModelCopyWith<T, CommonResponseModel<T>> get copyWith => _$CommonResponseModelCopyWithImpl<T, CommonResponseModel<T>>(this as CommonResponseModel<T>, _$identity);

  /// Serializes this CommonResponseModel to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonResponseModel<T>&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CommonResponseModel<$T>(status: $status, data: $data)';
}


}

/// @nodoc
abstract mixin class $CommonResponseModelCopyWith<T,$Res>  {
  factory $CommonResponseModelCopyWith(CommonResponseModel<T> value, $Res Function(CommonResponseModel<T>) _then) = _$CommonResponseModelCopyWithImpl;
@useResult
$Res call({
 int status, T data
});




}
/// @nodoc
class _$CommonResponseModelCopyWithImpl<T,$Res>
    implements $CommonResponseModelCopyWith<T, $Res> {
  _$CommonResponseModelCopyWithImpl(this._self, this._then);

  final CommonResponseModel<T> _self;
  final $Res Function(CommonResponseModel<T>) _then;

/// Create a copy of CommonResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}

}


/// Adds pattern-matching-related methods to [CommonResponseModel].
extension CommonResponseModelPatterns<T> on CommonResponseModel<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommonResponseModel<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommonResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommonResponseModel<T> value)  $default,){
final _that = this;
switch (_that) {
case _CommonResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommonResponseModel<T> value)?  $default,){
final _that = this;
switch (_that) {
case _CommonResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int status,  T data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommonResponseModel() when $default != null:
return $default(_that.status,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int status,  T data)  $default,) {final _that = this;
switch (_that) {
case _CommonResponseModel():
return $default(_that.status,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int status,  T data)?  $default,) {final _that = this;
switch (_that) {
case _CommonResponseModel() when $default != null:
return $default(_that.status,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _CommonResponseModel<T> implements CommonResponseModel<T> {
  const _CommonResponseModel({required this.status, required this.data});
  factory _CommonResponseModel.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$CommonResponseModelFromJson(json,fromJsonT);

@override final  int status;
@override final  T data;

/// Create a copy of CommonResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommonResponseModelCopyWith<T, _CommonResponseModel<T>> get copyWith => __$CommonResponseModelCopyWithImpl<T, _CommonResponseModel<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$CommonResponseModelToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommonResponseModel<T>&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CommonResponseModel<$T>(status: $status, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CommonResponseModelCopyWith<T,$Res> implements $CommonResponseModelCopyWith<T, $Res> {
  factory _$CommonResponseModelCopyWith(_CommonResponseModel<T> value, $Res Function(_CommonResponseModel<T>) _then) = __$CommonResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int status, T data
});




}
/// @nodoc
class __$CommonResponseModelCopyWithImpl<T,$Res>
    implements _$CommonResponseModelCopyWith<T, $Res> {
  __$CommonResponseModelCopyWithImpl(this._self, this._then);

  final _CommonResponseModel<T> _self;
  final $Res Function(_CommonResponseModel<T>) _then;

/// Create a copy of CommonResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? data = freezed,}) {
  return _then(_CommonResponseModel<T>(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

// dart format on
