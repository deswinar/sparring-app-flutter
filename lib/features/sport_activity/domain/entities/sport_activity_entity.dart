import 'package:equatable/equatable.dart';
import 'package:flutter_sparring/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_sparring/features/location/domain/entities/city_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/participant_entity.dart';

class SportActivityEntity extends Equatable {
  final int id;
  final String? title;
  final int? price;
  final int? priceDiscount;
  final int? slot;
  final String? address;
  final DateTime? activityDate;
  final String? startTime;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final UserEntity? organizer;
  final CityEntity? city;
  final List<ParticipantEntity>? participants;

  const SportActivityEntity({
    required this.id,
    this.title,
    this.price,
    this.priceDiscount,
    this.slot,
    this.address,
    this.activityDate,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.organizer,
    this.city,
    this.participants,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        priceDiscount,
        slot,
        address,
        activityDate,
        startTime,
        endTime,
        createdAt,
        updatedAt,
        organizer,
        city,
        participants,
      ];
}
