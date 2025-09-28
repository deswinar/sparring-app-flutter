import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/core/models/pagination_request_model.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';
import 'package:flutter_sparring/features/sport_category/data/datasources/sport_category_remote_datasource.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:flutter_sparring/features/sport_category/domain/repositories/sport_category_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failure_mapper.dart';

@LazySingleton(as: SportCategoryRepository)
class SportCategoryRepositoryImpl implements SportCategoryRepository {
  final SportCategoryRemoteDataSource _remote;

  const SportCategoryRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<SportCategoryEntity>>> getSportCategories({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remote.getSportCategories(
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
  Future<Either<Failure, SportCategoryEntity>> createSportCategory(String name) async {
    try {
      final response = await _remote.createSportCategory(name);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, SportCategoryEntity>> updateSportCategory(int id, String name) async {
    try {
      final response = await _remote.updateSportCategory(id, name);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, SportCategoryEntity>> deleteSportCategory(int id) async {
    try {
      final response = await _remote.deleteSportCategory(id);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}
