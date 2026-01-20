import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_response_model.freezed.dart';
part 'common_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class CommonResponseModel<T> with _$CommonResponseModel<T> {
  const factory CommonResponseModel({required int status, required T data}) = _CommonResponseModel<T>;

  factory CommonResponseModel.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$CommonResponseModelFromJson(json, fromJsonT);
}
