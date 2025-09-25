import 'package:dartz/dartz.dart';
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

  const LocationRepositoryImpl(this._remote);

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
      return Right(response.data.map((e) => e.toEntity()).toList());
    } catch (e) {
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
      if (provinceId > 0) {
        final response = await _remote.getCitiesByProvince(
          provinceId,
          PaginationRequestModel(
            isPaginate: true,
            perPage: perPage,
            page: page,
          )
        );
        return Right(response.data.map((e) => e.toEntity()).toList());
      } else {
        final response = await _remote.getCities(
          PaginationRequestModel(
            isPaginate: true,
            perPage: perPage,
            page: page,
          ),
        );
        return Right(response.data.map((e) => e.toEntity()).toList());
      }
    } catch (e) {
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
        )
      );
      return Right(response.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}
