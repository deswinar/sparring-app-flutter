// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
  id: (json['id'] as num).toInt(),
  provinceId: (json['provinceId'] as num).toInt(),
  name: json['name'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
  'id': instance.id,
  'provinceId': instance.provinceId,
  'name': instance.name,
  'type': instance.type,
};
