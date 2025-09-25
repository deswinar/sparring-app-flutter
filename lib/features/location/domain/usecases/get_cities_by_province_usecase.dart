import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/city_entity.dart';
import '../repositories/location_repository.dart';

class GetCitiesByProvinceParams {
  final int provinceId;
  final int page;
  final int perPage;

  const GetCitiesByProvinceParams({
    required this.provinceId,
    this.page = 1,
    this.perPage = 10,
  });
}

@injectable
class GetCitiesByProvinceUseCase {
  final LocationRepository repository;

  const GetCitiesByProvinceUseCase(this.repository);

  Future<Either<Failure, List<CityEntity>>> call(GetCitiesByProvinceParams params) async {
    // Validation
    if (params.provinceId <= 0) {
      return Left(ValidationFailure(
        message: 'ProvinceId must be greater than 0',
        code: 'INVALID_PROVINCE_ID',
      ));
    }

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

    return await repository.getCitiesByProvince(
      provinceId: params.provinceId,
      page: params.page,
      perPage: params.perPage,
    );
  }
}
