// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponseModel _$MessageResponseModelFromJson(
  Map<String, dynamic> json,
) => MessageResponseModel(
  error: json['error'] as bool,
  message: json['message'] as String,
);

Map<String, dynamic> _$MessageResponseModelToJson(
  MessageResponseModel instance,
) => <String, dynamic>{'error': instance.error, 'message': instance.message};
