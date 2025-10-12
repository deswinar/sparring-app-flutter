import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/repositories/sport_activity_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class GetSportActivitiesParams {
  final int page;
  final int perPage;
  final String? search;
  final int? sportCategoryId;
  final int? cityId;

  const GetSportActivitiesParams({
    this.page = 1,
    this.perPage = 10,
    this.search,
    this.sportCategoryId,
    this.cityId,
  });

  GetSportActivitiesParams copyWith({
    int? page,
    int? perPage,
    String? search,
    int? sportCategoryId,
    int? cityId,
  }) {
    return GetSportActivitiesParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      sportCategoryId: sportCategoryId ?? this.sportCategoryId,
      cityId: cityId ?? this.cityId,
    );
  }
}

@injectable
class GetSportActivitiesUseCase {
  final SportActivityRepository repository;

  const GetSportActivitiesUseCase(this.repository);

  Future<Either<Failure, List<SportActivityEntity>>> call(GetSportActivitiesParams params) async {
    // Validation example (can be extended later)
    if (params.page < 1) {
      return Left(ValidationFailure(
        message: 'Page must be greater than 0',
        code: 'INVALID_PAGE',
      ));
    }

    if (params.perPage < 1) {
      return Left(ValidationFailure(
        message: 'PerPage must be greater than 0',
        code: 'INVALID_PER_PAGE',
      ));
    }

    return await repository.getSportActivities(
      page: params.page,
      perPage: params.perPage,
      search: params.search,
      sportCategoryId: params.sportCategoryId,
      cityId: params.cityId,
    );
  }
}
