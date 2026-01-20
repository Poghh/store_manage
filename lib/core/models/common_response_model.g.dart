// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommonResponseModel<T> _$CommonResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _CommonResponseModel<T>(
  status: (json['status'] as num).toInt(),
  data: fromJsonT(json['data']),
);

Map<String, dynamic> _$CommonResponseModelToJson<T>(
  _CommonResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'status': instance.status,
  'data': toJsonT(instance.data),
};
