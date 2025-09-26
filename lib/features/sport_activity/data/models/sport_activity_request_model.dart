import 'package:json_annotation/json_annotation.dart';

part 'sport_activity_request_model.g.dart';

@JsonSerializable()
class SportActivityRequestModel {
  @JsonKey(name: 'sport_category_id')
  final int sportCategoryId;

  @JsonKey(name: 'city_id')
  final int cityId;

  final String title;
  final String description;
  final int slot;
  final int? price; // nullable in case free activity
  final String address;

  @JsonKey(name: 'activity_date')
  final String activityDate; // keep as String for request (yyyy-MM-dd)

  @JsonKey(name: 'start_time')
  final String startTime; // format: HH:mm

  @JsonKey(name: 'end_time')
  final String endTime;

  @JsonKey(name: 'map_url')
  final String mapUrl;

  const SportActivityRequestModel({
    required this.sportCategoryId,
    required this.cityId,
    required this.title,
    required this.description,
    required this.slot,
    required this.price,
    required this.address,
    required this.activityDate,
    required this.startTime,
    required this.endTime,
    required this.mapUrl,
  });

  factory SportActivityRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SportActivityRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportActivityRequestModelToJson(this);
}
