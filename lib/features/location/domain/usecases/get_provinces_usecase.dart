import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/province_entity.dart';
import '../repositories/location_repository.dart';

class GetProvincesParams {
  final int page;
  final int perPage;

  const GetProvincesParams({
    this.page = 1,
    this.perPage = 10,
  });
}

@injectable
class GetProvincesUseCase {
  final LocationRepository repository;

  const GetProvincesUseCase(this.repository);

  Future<Either<Failure, List<ProvinceEntity>>> call(GetProvincesParams params) async {
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

    return await repository.getProvinces(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
