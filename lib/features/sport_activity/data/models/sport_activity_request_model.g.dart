// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_activity_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportActivityRequestModel _$SportActivityRequestModelFromJson(
  Map<String, dynamic> json,
) => SportActivityRequestModel(
  sportCategoryId: (json['sport_category_id'] as num).toInt(),
  cityId: (json['city_id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  slot: (json['slot'] as num).toInt(),
  price: (json['price'] as num?)?.toInt(),
  address: json['address'] as String,
  activityDate: json['activity_date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  mapUrl: json['map_url'] as String,
);

Map<String, dynamic> _$SportActivityRequestModelToJson(
  SportActivityRequestModel instance,
) => <String, dynamic>{
  'sport_category_id': instance.sportCategoryId,
  'city_id': instance.cityId,
  'title': instance.title,
  'description': instance.description,
  'slot': instance.slot,
  'price': instance.price,
  'address': instance.address,
  'activity_date': instance.activityDate,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'map_url': instance.mapUrl,
};
