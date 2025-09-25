// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationRequestModel _$PaginationRequestModelFromJson(
  Map<String, dynamic> json,
) => PaginationRequestModel(
  isPaginate: json['is_paginate'] as bool? ?? true,
  perPage: (json['per_page'] as num?)?.toInt() ?? 10,
  page: (json['page'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$PaginationRequestModelToJson(
  PaginationRequestModel instance,
) => <String, dynamic>{
  'is_paginate': instance.isPaginate,
  'per_page': instance.perPage,
  'page': instance.page,
};
