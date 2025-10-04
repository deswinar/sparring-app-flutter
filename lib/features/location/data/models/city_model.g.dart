// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
  cityProvinceId: (json['province_id'] as num).toInt(),
  cityId: (json['city_id'] as num).toInt(),
  cityName: json['city_name'] as String,
  cityNameFull: json['city_name_full'] as String,
  cityType: json['city_type'] as String,
  cityLat: (json['city_lat'] as num?)?.toDouble(),
  cityLon: (json['city_lon'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
  'city_id': instance.cityId,
  'province_id': instance.cityProvinceId,
  'city_name': instance.cityName,
  'city_name_full': instance.cityNameFull,
  'city_type': instance.cityType,
  'city_lat': instance.cityLat,
  'city_lon': instance.cityLon,
};
