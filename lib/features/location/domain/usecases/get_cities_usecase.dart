import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/city_entity.dart';
import '../repositories/location_repository.dart';

class GetCitiesParams {
  final int provinceId;
  final int page;
  final int perPage;

  const GetCitiesParams({
    this.provinceId = 0,
    this.page = 1,
    this.perPage = 10,
  });
}

@injectable
class GetCitiesUseCase {
  final LocationRepository repository;

  const GetCitiesUseCase(this.repository);

  Future<Either<Failure, List<CityEntity>>> call(GetCitiesParams params) async {
    // Validation
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

    return await repository.getCities(
      provinceId: params.provinceId,
      page: params.page,
      perPage: params.perPage,
    );
  }
}
