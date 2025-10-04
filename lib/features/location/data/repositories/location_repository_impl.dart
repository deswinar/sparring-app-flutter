import 'package:flutter_sparring/core/bloc/app_bloc_observer.dart';
import 'package:flutter_sparring/features/location/data/datasources/location_local_datasource.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/core/models/pagination_request_model.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/province_entity.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_datasource.dart';
import '../../../../core/errors/failure_mapper.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remote;
  final LocationLocalDataSource _local;

  const LocationRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<Failure, List<ProvinceEntity>>> getProvinces({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remote.getProvinces(
        PaginationRequestModel(
          isPaginate: true,
          perPage: perPage,
          page: page,
        ),
      );

      final entities = response.result.data.map((e) => e.toEntity()).toList();

      // Cache locally
      await _local.clearProvinces();
      await _local.cacheProvinces(entities);

      return Right(entities);
    } catch (e) {
      // Remote failed, fallback to local
      final cached = await _local.getCachedProvinces();
      if (cached.isNotEmpty) {
        return Right(cached);
      }

      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCities({
    int provinceId = 0,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = (provinceId > 0)
          ? await _remote.getCitiesByProvince(
              provinceId,
              PaginationRequestModel(
                isPaginate: true,
                perPage: perPage,
                page: page,
              ),
            )
          : await _remote.getCities(
              PaginationRequestModel(
                isPaginate: true,
                perPage: perPage,
                page: page,
              ),
            );

      final entities = response.result.data.map((e) => e.toEntity()).toList();

      // Cache locally
      await _local.cacheCities(entities);

      return Right(entities);
    } catch (e) {
      // Remote failed, fallback to local
      final cached = (provinceId > 0)
          ? await _local.getCachedCitiesByProvince(provinceId)
          : await _local.getCachedCities();

      if (cached.isNotEmpty) {
        return Right(cached);
      }

      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCitiesByProvince({
    required int provinceId,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remote.getCitiesByProvince(
        provinceId,
        PaginationRequestModel(
          isPaginate: true,
          perPage: perPage,
          page: page,
        ),
      );

      logger.i('getCitiesByProvince: response = $response');

      final entities = response.result.data.map((e) => e.toEntity()).toList();

      logger.i('getCitiesByProvince: entities = $entities');

      // Cache locally
      await _local.cacheCities(entities);

      return Right(entities);
    } catch (e) {
      final cached = await _local.getCachedCitiesByProvince(provinceId);
      if (cached.isNotEmpty) {
        return Right(cached);
      }

      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}
