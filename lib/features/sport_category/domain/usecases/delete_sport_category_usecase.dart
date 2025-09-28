import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:flutter_sparring/features/sport_category/domain/repositories/sport_category_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class DeleteSportCategoryParams {
  final int id;

  const DeleteSportCategoryParams({
    required this.id,
  });
}

@injectable
class DeleteSportCategoryUsecase {
  final SportCategoryRepository repository;

  const DeleteSportCategoryUsecase(this.repository);

  Future<Either<Failure, SportCategoryEntity>> call(DeleteSportCategoryParams params) async {
    return await repository.deleteSportCategory(params.id);
  }
}
