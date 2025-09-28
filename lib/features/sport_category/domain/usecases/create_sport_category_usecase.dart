import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:flutter_sparring/features/sport_category/domain/repositories/sport_category_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class CreateSportCategoryParams {
  final String name;

  const CreateSportCategoryParams({
    required this.name,
  });
}

@injectable
class CreateSportCategoryUsecase {
  final SportCategoryRepository repository;

  const CreateSportCategoryUsecase(this.repository);

  Future<Either<Failure, SportCategoryEntity>> call(CreateSportCategoryParams params) async {
    return await repository.createSportCategory(params.name);
  }
}
