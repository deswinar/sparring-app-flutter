// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportActivityModel _$SportActivityModelFromJson(Map<String, dynamic> json) =>
    SportActivityModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num?)?.toInt(),
      priceDiscount: (json['price_discount'] as num?)?.toInt(),
      slot: (json['slot'] as num).toInt(),
      address: json['address'] as String,
      activityDate: json['activity_date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      organizer: UserModel.fromJson(json['organizer'] as Map<String, dynamic>),
      city: CityModel.fromJson(json['city'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SportActivityModelToJson(SportActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'price_discount': instance.priceDiscount,
      'slot': instance.slot,
      'address': instance.address,
      'activity_date': instance.activityDate,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'organizer': instance.organizer.toJson(),
      'city': instance.city.toJson(),
      'participants': instance.participants.map((e) => e.toJson()).toList(),
    };
