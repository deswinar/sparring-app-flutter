// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponseModel<T> _$PaginatedResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginatedResponseModel<T>(
  currentPage: (json['current_page'] as num).toInt(),
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
  lastPage: (json['last_page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$PaginatedResponseModelToJson<T>(
  PaginatedResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'data': instance.data.map(toJsonT).toList(),
  'last_page': instance.lastPage,
  'per_page': instance.perPage,
  'total': instance.total,
};
