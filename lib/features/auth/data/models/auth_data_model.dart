import 'package:json_annotation/json_annotation.dart';

part 'auth_data_model.g.dart';

@JsonSerializable()
class AuthDataModel {
  final String token;
  final String name;
  final String email;

  const AuthDataModel({
    required this.token,
    required this.name,
    required this.email,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataModelToJson(this);
}
