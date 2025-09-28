import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';

import '../entities/province_entity.dart';
import '../entities/city_entity.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<ProvinceEntity>>> getProvinces({
    int page = 1,
    int perPage = 10,
  });

  Future<Either<Failure, List<CityEntity>>> getCities({
    int provinceId = 0,
    int page = 1,
    int perPage = 10,
  });

  Future<Either<Failure, List<CityEntity>>> getCitiesByProvince({
    required int provinceId,
    int page = 1,
    int perPage = 10,
  });
}
