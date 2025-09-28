import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';

abstract class SportActivityRepository {
  Future<Either<Failure, List<SportActivityEntity>>> getSportActivities({
    int page = 1,
    int perPage = 10,
    String? search,
    int? sportCategoryId,
    int? cityId,
  });

  Future<Either<Failure, SportActivityEntity>> getSportActivityById(int id);

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
  });

  Future<Either<Failure, SportActivityEntity>> updateSportActivity(
    int id, {
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
  });

  Future<Either<Failure, SportActivityEntity>> deleteSportActivity(int id);
}
