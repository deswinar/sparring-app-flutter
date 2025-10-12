import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/base_response_model.dart';

part 'file_upload_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class FileUploadRemoteDataSource {
  @factoryMethod
  factory FileUploadRemoteDataSource(Dio dio) = _FileUploadRemoteDataSource;

  // File upload
  @POST(ApiConstants.uploadFileEndpoint)
  @MultiPart()
  Future<BaseResponseModel<String>> uploadFile(
    @Part(name: "file") File file,
  );

  // Image upload
  @POST(ApiConstants.uploadImageEndpoint)
  @MultiPart()
  Future<BaseResponseModel<String>> uploadImage(
    @Part(name: "file") File file,
  );
}
