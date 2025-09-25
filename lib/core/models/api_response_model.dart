import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T> {
  final bool success;
  final T data;
  final String message;

  const ApiResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseModelToJson(this, toJsonT);
}
