import 'package:dio/dio.dart';
import 'package:flutter_sparring/core/models/base_response_model.dart';
import 'package:flutter_sparring/core/models/paginated_response_model.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/sport_activity_list_request_model.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/sport_activity_model.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/sport_activity_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants.dart';

part 'sport_activity_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class SportActivityRemoteDataSource {
  @factoryMethod
  factory SportActivityRemoteDataSource(Dio dio) = _SportActivityRemoteDataSource;

  @GET(ApiConstants.sportCategoriesEndpoint)
  Future<PaginatedResponseModel<SportActivityModel>> getSportActivities(
    @Queries() SportActivityListRequestModel request,
  );

  @GET(ApiConstants.sportActivityByIdEndpoint)
  Future<BaseResponseModel<SportActivityModel>> getSportActivityById(@Path('id') int id);

  @POST(ApiConstants.createSportActivityEndpoint)
  Future<BaseResponseModel<SportActivityModel>> createSportActivity(
    @Body() SportActivityRequestModel request,
  );

  @PUT(ApiConstants.updateSportActivityEndpoint)
  Future<BaseResponseModel<SportActivityModel>> updateSportActivity(
    @Path('id') int id,
    @Body() SportActivityRequestModel request,
  );

  @DELETE(ApiConstants.deleteSportActivityEndpoint)
  Future<BaseResponseModel<SportActivityModel>> deleteSportActivity(@Path('id') int id);
}
