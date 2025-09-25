import 'package:dio/dio.dart';
import 'package:flutter_sparring/core/models/api_response_model.dart';
import 'package:flutter_sparring/features/auth/data/models/auth_data_model.dart';
import 'package:flutter_sparring/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

part 'auth_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class AuthRemoteDataSource {
  @factoryMethod
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST(ApiConstants.loginEndpoint)
  Future<ApiResponseModel<AuthDataModel>> login(@Body() LoginRequestModel request);

  @POST(ApiConstants.registerEndpoint)
  Future<ApiResponseModel<AuthDataModel>> register(@Body() RegisterRequestModel request);

  @POST(ApiConstants.logoutEndpoint)
  Future<void> logout();

  @GET(ApiConstants.userProfileEndpoint)
  Future<ApiResponseModel<UserModel>> getCurrentUser();

  @POST(ApiConstants.refreshTokenEndpoint)
  Future<ApiResponseModel<AuthDataModel>> refreshToken(@Body() Map<String, String> request);
}
