import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:flutter_sparring/features/sport_category/domain/repositories/sport_category_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class GetSportCategoriesParams {
  final int page;
  final int perPage;

  const GetSportCategoriesParams({
    this.page = 1,
    this.perPage = 10,
  });
}

@injectable
class GetSportCategoriesUseCase {
  final SportCategoryRepository repository;

  const GetSportCategoriesUseCase(this.repository);

  Future<Either<Failure, List<SportCategoryEntity>>> call(GetSportCategoriesParams params) async {
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

    return await repository.getSportCategories(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
