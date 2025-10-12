import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';
import 'package:flutter_sparring/features/sport_activity/data/datasources/sport_activity_remote_datasource.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/sport_activity_list_request_model.dart';
import 'package:flutter_sparring/features/sport_activity/data/models/sport_activity_request_model.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/repositories/sport_activity_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failure_mapper.dart';

@LazySingleton(as: SportActivityRepository)
class SportActivityRepositoryImpl implements SportActivityRepository {
  final SportActivityRemoteDataSource _remote;

  const SportActivityRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<SportActivityEntity>>> getSportActivities({
    int page = 1,
    int perPage = 10,
    String? search,
    int? sportCategoryId,
    int? cityId,
  }) async {
    try {
      final response = await _remote.getSportActivities(
        SportActivityListRequestModel(
          isPaginate: true,
          perPage: perPage,
          page: page,
          search: search,
          sportCategoryId: sportCategoryId,
          cityId: cityId,
        ),
      );
      return Right(response.result.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, SportActivityEntity>> getSportActivityById(int id) async {
    try {
      final response = await _remote.getSportActivityById(id);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, SportActivityEntity>> createSportActivity({
    required int sportCategoryId,
    required int cityId,
    required String title,
    required String description,
    required int slot,
    int? price,
    required String address,
    required String activityDate,
    required String startTime,
    required String endTime,
    required String mapUrl,
  }) async {
    try {
      final request = SportActivityRequestModel(
        sportCategoryId: sportCategoryId,
        cityId: cityId,
        title: title,
        description: description,
        slot: slot,
        price: price,
        address: address,
        activityDate: activityDate,
        startTime: startTime,
        endTime: endTime,
        mapUrl: mapUrl,
      );
      final response = await _remote.createSportActivity(request);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, SportActivityEntity>> updateSportActivity(int id, {
    required int sportCategoryId,
    required int cityId,
    required String title,
    required String description,
    required int slot,
    int? price,
    required String address,
    required String activityDate,
    required String startTime,
    required String endTime,
    required String mapUrl,
  }) async {
    try {
      final request = SportActivityRequestModel(
        sportCategoryId: sportCategoryId,
        cityId: cityId,
        title: title,
        description: description,
        slot: slot,
        price: price,
        address: address,
        activityDate: activityDate,
        startTime: startTime,
        endTime: endTime,
        mapUrl: mapUrl,
      );
      final response = await _remote.updateSportActivity(id, request);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, SportActivityEntity>> deleteSportActivity(int id) async {
    try {
      final response = await _remote.deleteSportActivity(id);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}
