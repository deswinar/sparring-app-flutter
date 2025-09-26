import 'package:flutter_sparring/core/models/pagination_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sport_activity_list_request_model.g.dart';

@JsonSerializable()
class SportActivityListRequestModel extends PaginationRequestModel {
  final String? search;

  @JsonKey(name: 'sport_category_id')
  final int? sportCategoryId;

  @JsonKey(name: 'city_id')
  final int? cityId;

  SportActivityListRequestModel({
    super.isPaginate = true,
    super.perPage = 10,
    super.page = 1,
    this.search,
    this.sportCategoryId,
    this.cityId,
  });

  factory SportActivityListRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SportActivityListRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$SportActivityListRequestModelToJson(this);
}
