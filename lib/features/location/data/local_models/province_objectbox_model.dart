// lib/features/location/data/local_models/province_objectbox_model.dart
import 'package:objectbox/objectbox.dart';
import '../../domain/entities/province_entity.dart';
import 'city_objectbox_model.dart';

@Entity()
class ProvinceObjectBoxModel {
  @Id()
  int id = 0;

  int apiId;
  String name;
  String abbreviation;

  // One province has many cities
  final cities = ToMany<CityObjectBoxModel>();

  ProvinceObjectBoxModel({
    this.id = 0,
    required this.apiId,
    required this.name,
    required this.abbreviation,
  });

  // Mapper to domain entity
  ProvinceEntity toEntity() => ProvinceEntity(
        id: apiId,
        name: name,
        abbreviation: abbreviation,
      );

  // Mapper from domain entity
  static ProvinceObjectBoxModel fromEntity(ProvinceEntity entity) {
    return ProvinceObjectBoxModel(
      apiId: entity.id,
      name: entity.name,
      abbreviation: entity.abbreviation,
    );
  }
}
