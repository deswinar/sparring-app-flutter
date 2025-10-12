import 'package:equatable/equatable.dart';
import 'package:flutter_sparring/features/auth/domain/entities/user_entity.dart';

class ParticipantEntity extends Equatable {
  final int id;
  final int sportActivityId;
  final int userId;
  final UserEntity user;

  const ParticipantEntity({
    required this.id,
    required this.sportActivityId,
    required this.userId,
    required this.user,
  });

  @override
  List<Object?> get props => [id, sportActivityId, userId, user];
}
