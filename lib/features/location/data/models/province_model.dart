import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/province_entity.dart';

part 'province_model.g.dart';

@JsonSerializable()
class ProvinceModel extends ProvinceEntity {


  const ProvinceModel({
    required super.id,
    required super.name,
    required super.abbreviation,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);

  factory ProvinceModel.fromEntity(ProvinceEntity entity) {
    return ProvinceModel(
      id: entity.id,
      name: entity.name,
      abbreviation: entity.abbreviation,
    );
  }

  ProvinceEntity toEntity() {
    return ProvinceEntity(
      id: id,
      name: name,
      abbreviation: abbreviation,
    );
  }
}
