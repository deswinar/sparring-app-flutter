// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_activity_list_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportActivityListRequestModel _$SportActivityListRequestModelFromJson(
  Map<String, dynamic> json,
) => SportActivityListRequestModel(
  isPaginate: json['is_paginate'] as bool? ?? true,
  perPage: (json['per_page'] as num?)?.toInt() ?? 10,
  page: (json['page'] as num?)?.toInt() ?? 1,
  search: json['search'] as String?,
  sportCategoryId: (json['sport_category_id'] as num?)?.toInt(),
  cityId: (json['city_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$SportActivityListRequestModelToJson(
  SportActivityListRequestModel instance,
) => <String, dynamic>{
  'is_paginate': instance.isPaginate,
  'per_page': instance.perPage,
  'page': instance.page,
  'search': instance.search,
  'sport_category_id': instance.sportCategoryId,
  'city_id': instance.cityId,
};
