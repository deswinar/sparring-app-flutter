import 'package:json_annotation/json_annotation.dart';

part 'message_response_model.g.dart';

@JsonSerializable()
class MessageResponseModel {
  final bool error;
  final String message;

  const MessageResponseModel({required this.error, required this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);
}
