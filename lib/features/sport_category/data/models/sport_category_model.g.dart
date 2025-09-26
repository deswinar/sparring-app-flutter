// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportCategoryModel _$SportCategoryModelFromJson(Map<String, dynamic> json) =>
    SportCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SportCategoryModelToJson(SportCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
