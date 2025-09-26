import 'package:json_annotation/json_annotation.dart';

part 'paginated_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponseModel<T> {
  @JsonKey(name: "current_page")
  final int currentPage;

  final List<T> data;

  @JsonKey(name: "last_page")
  final int lastPage;

  @JsonKey(name: "per_page")
  final int perPage;

  @JsonKey(name: "total")
  final int total;

  const PaginatedResponseModel({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseModelToJson(this, toJsonT);
}
