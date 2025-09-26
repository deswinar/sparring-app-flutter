import 'package:dio/dio.dart';
import 'package:flutter_sparring/core/models/base_response_model.dart';
import 'package:flutter_sparring/core/models/paginated_response_model.dart';
import 'package:flutter_sparring/core/models/pagination_request_model.dart';
import 'package:flutter_sparring/features/sport_category/data/models/sport_category_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants.dart';

part 'sport_category_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class SportCategoryRemoteDataSource {
  @factoryMethod
  factory SportCategoryRemoteDataSource(Dio dio) = _SportCategoryRemoteDataSource;

  @GET(ApiConstants.sportCategoriesEndpoint)
  Future<PaginatedResponseModel<SportCategoryModel>> getSportCategories(
    @Queries() PaginationRequestModel request,
  );

  @POST(ApiConstants.createSportCategoryEndpoint)
  Future<BaseResponseModel<SportCategoryModel>> createSportCategory(@Body() String name);

  @POST(ApiConstants.updateSportCategoryEndpoint)
  Future<BaseResponseModel<SportCategoryModel>> updateSportCategory(@Path('id') int id, @Body() String name);

  @DELETE(ApiConstants.deleteSportCategoryEndpoint)
  Future<BaseResponseModel<SportCategoryModel>> deleteSportCategory(@Path('id') int id);
}
