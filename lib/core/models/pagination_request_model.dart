import 'package:json_annotation/json_annotation.dart';

part 'pagination_request_model.g.dart';

@JsonSerializable()
class PaginationRequestModel {
  @JsonKey(name: 'is_paginate')
  final bool isPaginate;

  @JsonKey(name: 'per_page')
  final int perPage;

  final int page;

  PaginationRequestModel({
    this.isPaginate = true,
    this.perPage = 10,
    this.page = 1,
  });

  factory PaginationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationRequestModelToJson(this);
}
