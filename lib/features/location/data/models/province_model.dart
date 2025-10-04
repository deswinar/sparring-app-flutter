import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/province_entity.dart';

part 'province_model.g.dart';

@JsonSerializable()
class ProvinceModel extends ProvinceEntity {
  @JsonKey(name: 'province_id')
  final int provinceId;

  @JsonKey(name: 'province_name')
  final String provinceName;

  @JsonKey(name: 'province_name_abbr')
  final String provinceNameAbbr;

  @JsonKey(name: 'iso_code')
  final String? isoCode;

  @JsonKey(name: 'iso_name')
  final String? isoName;

  @JsonKey(name: 'iso_type')
  final String? isoType;

  @JsonKey(name: 'iso_geounit')
  final String? isoGeounit;

  @JsonKey(name: 'province_capital_city_id')
  final int? capitalCityId;

  final int? timezone;

  @JsonKey(name: 'province_lat')
  final double? lat;

  @JsonKey(name: 'province_lon')
  final double? lon;

  const ProvinceModel({
    required this.provinceId,
    required this.provinceName,
    required this.provinceNameAbbr,
    this.isoCode,
    this.isoName,
    this.isoType,
    this.isoGeounit,
    this.capitalCityId,
    this.timezone,
    this.lat,
    this.lon,
  }) : super(id: provinceId, name: provinceName, abbreviation: provinceNameAbbr);

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);

  factory ProvinceModel.fromEntity(ProvinceEntity entity) {
    return ProvinceModel(
      provinceId: entity.id,
      provinceName: entity.name,
      provinceNameAbbr: entity.abbreviation,
    );
  }

  ProvinceEntity toEntity() {
    return ProvinceEntity(
      id: provinceId,
      name: provinceName,
      abbreviation: provinceNameAbbr,
    );
  }
}