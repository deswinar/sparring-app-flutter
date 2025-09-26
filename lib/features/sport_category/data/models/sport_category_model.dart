import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sport_category_model.g.dart';

@JsonSerializable()
class SportCategoryModel extends SportCategoryEntity {
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const SportCategoryModel({
    required super.id,
    required super.name,
    this.createdAt,
    this.updatedAt,
  });

  factory SportCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SportCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportCategoryModelToJson(this);

  factory SportCategoryModel.fromEntity(SportCategoryEntity entity) {
    return SportCategoryModel(
      id: entity.id,
      name: entity.name,
    );
  }

  SportCategoryEntity toEntity() {
    return SportCategoryEntity(
      id: id,
      name: name,
    );
  }
}
