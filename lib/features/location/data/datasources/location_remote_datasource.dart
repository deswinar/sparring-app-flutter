import 'package:dio/dio.dart';
import 'package:flutter_sparring/core/models/base_response_model.dart';
import 'package:flutter_sparring/core/models/paginated_response_model.dart';
import 'package:flutter_sparring/core/models/pagination_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/province_model.dart';
import '../models/city_model.dart';
import '../../../../core/constants/api_constants.dart';

part 'location_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class LocationRemoteDataSource {
  @factoryMethod
  factory LocationRemoteDataSource(Dio dio) = _LocationRemoteDataSource;

  @GET(ApiConstants.provincesEndpoint)
  Future<BaseResponseModel<PaginatedResponseModel<ProvinceModel>>> getProvinces(
    @Queries() PaginationRequestModel request,
  );

  @GET(ApiConstants.citiesEndpoint)
  Future<BaseResponseModel<PaginatedResponseModel<CityModel>>> getCities(
    @Queries() PaginationRequestModel request,
  );

  @GET(ApiConstants.citiesByProvinceIdEndpoint)
  Future<BaseResponseModel<PaginatedResponseModel<CityModel>>> getCitiesByProvince(
    @Path('provinceId') int provinceId,
    @Queries() PaginationRequestModel request,
  );
}
