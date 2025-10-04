// lib/features/location/data/local_models/city_objectbox_model.dart
import 'package:objectbox/objectbox.dart';
import '../../domain/entities/city_entity.dart';
import 'province_objectbox_model.dart';

@Entity()
class CityObjectBoxModel {
  @Id()
  int id = 0;

  int apiId;
  String name;
  String nameFull;
  String type;

  // Relation: each city belongs to one province
  final province = ToOne<ProvinceObjectBoxModel>();

  CityObjectBoxModel({
    this.id = 0,
    required this.apiId,
    required this.name,
    required this.nameFull,
    required this.type,
  });

  // Mapper to domain entity
  CityEntity toEntity() => CityEntity(
        id: apiId,
        provinceId: province.targetId,
        name: name,
        nameFull: nameFull,
        type: type,
      );

  // Mapper from domain entity
  static CityObjectBoxModel fromEntity(CityEntity entity, int provinceDbId,) {
    final city = CityObjectBoxModel(
      apiId: entity.id,
      name: entity.name,
      nameFull: entity.nameFull,
      type: entity.type,
    );
    city.province.targetId = provinceDbId; // link to province
    return city;
  }
}
