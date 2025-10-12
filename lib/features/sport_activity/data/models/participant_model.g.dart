// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    ParticipantModel(
      id: (json['id'] as num).toInt(),
      sportActivityId: (json['sport_activity_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sport_activity_id': instance.sportActivityId,
      'user_id': instance.userId,
      'user': instance.user.toJson(),
    };
