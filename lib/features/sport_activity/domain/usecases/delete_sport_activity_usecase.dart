import 'package:dartz/dartz.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/repositories/sport_activity_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class DeleteSportActivityParams {
  final int id;

  const DeleteSportActivityParams({
    required this.id,
  });
}

@injectable
class DeleteSportActivityUsecase {
  final SportActivityRepository repository;

  const DeleteSportActivityUsecase(this.repository);

  Future<Either<Failure, SportActivityEntity>> call(DeleteSportActivityParams params) async {
    return await repository.deleteSportActivity(params.id);
  }
}
