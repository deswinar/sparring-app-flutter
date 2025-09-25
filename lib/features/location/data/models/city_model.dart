import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/city_entity.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends CityEntity {

  const CityModel({
    required super.id,
    required super.provinceId,
    required super.name,
    required super.type,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  factory CityModel.fromEntity(CityEntity entity) {
    return CityModel(
      id: entity.id,
      provinceId: entity.provinceId,
      name: entity.name,
      type: entity.type,
    );
  }
  
  CityEntity toEntity() {
    return CityEntity(
      id: id,
      provinceId: provinceId,
      name: name,
      type: type,
    );
  }
}
