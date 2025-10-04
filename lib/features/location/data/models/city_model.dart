import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/city_entity.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends CityEntity {
  @JsonKey(name: 'city_id')
  final int cityId;

  @JsonKey(name: 'province_id')
  // ignore: overridden_fields
  final int cityProvinceId;

  @JsonKey(name: 'city_name')
  final String cityName;

  @JsonKey(name: 'city_name_full')
  final String cityNameFull;

  @JsonKey(name: 'city_type')
  final String cityType;

  @JsonKey(name: 'city_lat')
  final double? cityLat;

  @JsonKey(name: 'city_lon')
  final double? cityLon;

  const CityModel({
    required this.cityProvinceId,
    required this.cityId,
    required this.cityName,
    required this.cityNameFull,
    required this.cityType,
    this.cityLat,
    this.cityLon,
  }) : super(provinceId: cityProvinceId, id: cityId, name: cityName, type: cityType, nameFull: cityNameFull);

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  factory CityModel.fromEntity(CityEntity entity) {
    return CityModel(
      cityId: entity.id,
      cityProvinceId: entity.provinceId,
      cityName: entity.name,
      cityNameFull: entity.name,
      cityType: entity.type,
    );
  }
  
  CityEntity toEntity() {
    return CityEntity(
      id: cityId,
      provinceId: cityProvinceId,
      name: cityName,
      nameFull: cityNameFull,
      type: cityType,
    );
  }
}
