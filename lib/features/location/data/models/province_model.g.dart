// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) =>
    ProvinceModel(
      provinceId: (json['province_id'] as num).toInt(),
      provinceName: json['province_name'] as String,
      provinceNameAbbr: json['province_name_abbr'] as String,
      isoCode: json['iso_code'] as String?,
      isoName: json['iso_name'] as String?,
      isoType: json['iso_type'] as String?,
      isoGeounit: json['iso_geounit'] as String?,
      capitalCityId: (json['province_capital_city_id'] as num?)?.toInt(),
      timezone: (json['timezone'] as num?)?.toInt(),
      lat: (json['province_lat'] as num?)?.toDouble(),
      lon: (json['province_lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProvinceModelToJson(ProvinceModel instance) =>
    <String, dynamic>{
      'province_id': instance.provinceId,
      'province_name': instance.provinceName,
      'province_name_abbr': instance.provinceNameAbbr,
      'iso_code': instance.isoCode,
      'iso_name': instance.isoName,
      'iso_type': instance.isoType,
      'iso_geounit': instance.isoGeounit,
      'province_capital_city_id': instance.capitalCityId,
      'timezone': instance.timezone,
      'province_lat': instance.lat,
      'province_lon': instance.lon,
    };
