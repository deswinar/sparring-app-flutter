// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseModel<T> _$ApiResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiResponseModel<T>(
  success: json['success'] as bool,
  data: fromJsonT(json['data']),
  message: json['message'] as String,
);

Map<String, dynamic> _$ApiResponseModelToJson<T>(
  ApiResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'data': toJsonT(instance.data),
  'message': instance.message,
};
