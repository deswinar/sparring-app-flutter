import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_sparring/features/auth/data/models/user_model.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/participant_entity.dart';

part 'participant_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ParticipantModel {
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  final UserModel user;

  const ParticipantModel({
    required this.id,
    required this.userId,
    required this.user,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);

  ParticipantEntity toEntity() => ParticipantEntity(
        id: id,
        userId: userId,
        user: user.toEntity(),
      );
}
