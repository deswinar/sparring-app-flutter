import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_sparring/features/auth/data/models/user_model.dart';
import 'package:flutter_sparring/features/location/data/models/city_model.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/participant_model.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';

part 'sport_activity_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SportActivityModel {
  final int id;
  final String title;
  final int? price;

  @JsonKey(name: 'price_discount')
  final int? priceDiscount;

  final int slot;
  final String address;

  @JsonKey(name: 'activity_date')
  final String activityDate;

  @JsonKey(name: 'start_time')
  final String startTime;

  @JsonKey(name: 'end_time')
  final String endTime;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  final UserModel organizer;
  final CityModel city;
  final List<ParticipantModel> participants;

  const SportActivityModel({
    required this.id,
    required this.title,
    required this.price,
    required this.priceDiscount,
    required this.slot,
    required this.address,
    required this.activityDate,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.organizer,
    required this.city,
    required this.participants,
  });

  factory SportActivityModel.fromJson(Map<String, dynamic> json) =>
      _$SportActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportActivityModelToJson(this);

  SportActivityEntity toEntity() => SportActivityEntity(
        id: id,
        title: title,
        price: price,
        priceDiscount: priceDiscount,
        slot: slot,
        address: address,
        activityDate: DateTime.parse(activityDate),
        startTime: startTime,
        endTime: endTime,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
        organizer: organizer.toEntity(),
        city: city.toEntity(),
        participants: participants.map((e) => e.toEntity()).toList(),
      );
}
