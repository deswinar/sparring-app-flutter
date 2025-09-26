import 'package:dartz/dartz.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/repositories/sport_activity_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class GetSportActivityByIdParams {
  final int id;

  const GetSportActivityByIdParams({
    required this.id,
  });
}

@injectable
class GetSportActivityByIdUseCase {
  final SportActivityRepository repository;

  const GetSportActivityByIdUseCase(this.repository);

  Future<Either<Failure, SportActivityEntity>> call(GetSportActivityByIdParams params) async {
    return await repository.getSportActivityById(params.id);
  }
}
