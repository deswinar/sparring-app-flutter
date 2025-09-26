import 'package:dartz/dartz.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';

abstract class SportCategoryRepository {
  Future<Either<Failure, List<SportCategoryEntity>>> getSportCategories({
    int page = 1,
    int perPage = 10,
  });

  Future<Either<Failure, SportCategoryEntity>> createSportCategory(String name);

  Future<Either<Failure, SportCategoryEntity>> updateSportCategory(
      int id, String name);

  Future<Either<Failure, SportCategoryEntity>> deleteSportCategory(int id);
}
