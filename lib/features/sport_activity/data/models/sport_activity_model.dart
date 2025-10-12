import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_sparring/features/auth/data/models/user_model.dart';
import 'package:flutter_sparring/features/location/data/models/city_model.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/participant_model.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';

part 'sport_activity_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SportActivityModel {
  final int id;
  final String? title;
  final int? price;

  final int? priceDiscount;

  final int? slot;
  final String? address;

  final String? activityDate;

  final String? startTime;

  final String? endTime;

  final String? createdAt;

  final String? updatedAt;

  final UserModel? organizer;
  final CityModel? city;
  final List<ParticipantModel>? participants;

  const SportActivityModel({
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

  factory SportActivityModel.fromJson(Map<String, dynamic> json) =>
      _$SportActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportActivityModelToJson(this);

  SportActivityEntity toEntity() => SportActivityEntity(
        id: id,
        title: title ?? '',
        price: price,
        priceDiscount: priceDiscount,
        slot: slot ?? 0,
        address: address ?? '',
        activityDate: activityDate != null
            ? DateTime.tryParse(activityDate!) ?? DateTime.now()
            : DateTime.now(),
        startTime: startTime ?? '',
        endTime: endTime ?? '',
        createdAt: createdAt != null
            ? DateTime.tryParse(createdAt!) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: updatedAt != null
            ? DateTime.tryParse(updatedAt!) ?? DateTime.now()
            : DateTime.now(),
        organizer: organizer?.toEntity(),
        city: city?.toEntity(),
        participants:
            participants?.map((e) => e.toEntity()).toList() ?? const [],
      );
}
