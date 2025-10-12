import 'package:json_annotation/json_annotation.dart';

part 'update_status_request_model.g.dart';

@JsonSerializable()
class UpdateStatusRequestModel {
  final String status;

  const UpdateStatusRequestModel({required this.status});

  factory UpdateStatusRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateStatusRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStatusRequestModelToJson(this);
}
