import 'package:dartz/dartz.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:flutter_sparring/features/sport_category/domain/repositories/sport_category_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class UpdateSportCategoryParams {
  final int id;
  final String name;

  const UpdateSportCategoryParams({
    required this.id,
    required this.name,
  });
}

@injectable
class UpdateSportCategoryUsecase {
  final SportCategoryRepository repository;

  const UpdateSportCategoryUsecase(this.repository);

  Future<Either<Failure, SportCategoryEntity>> call(UpdateSportCategoryParams params) async {
    return await repository.updateSportCategory(params.id, params.name);
  }
}
