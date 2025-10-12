import 'package:flutter_sparring/features/file_upload/domain/entities/file_upload_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_upload_response_model.g.dart';

@JsonSerializable()
class FileUploadResponseModel {
  final String result;

  const FileUploadResponseModel({required this.result});

  factory FileUploadResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadResponseModelToJson(this);

  FileUploadEntity toEntity() => FileUploadEntity(url: result);
}
