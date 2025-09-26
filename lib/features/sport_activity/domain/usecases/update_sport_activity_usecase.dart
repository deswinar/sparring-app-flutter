import 'package:dartz/dartz.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/repositories/sport_activity_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

class UpdateSportActivityParams {
  final int id;
  final int sportCategoryId;
  final int cityId;
  final String title;
  final String description;
  final int slot;
  final int? price;
  final String address;
  final String activityDate; // keep as String if backend expects YYYY-MM-DD
  final String startTime;    // e.g. "06:00"
  final String endTime;      // e.g. "07:00"
  final String mapUrl;

  const UpdateSportActivityParams({
    required this.id,
    required this.sportCategoryId,
    required this.cityId,
    required this.title,
    required this.description,
    required this.slot,
    this.price,
    required this.address,
    required this.activityDate,
    required this.startTime,
    required this.endTime,
    required this.mapUrl,
  });
}

@injectable
class UpdateSportActivityUsecase {
  final SportActivityRepository repository;

  const UpdateSportActivityUsecase(this.repository);

  Future<Either<Failure, SportActivityEntity>> call(UpdateSportActivityParams params) async {
    return await repository.updateSportActivity(
      params.id,
      sportCategoryId: params.sportCategoryId,
      cityId: params.cityId,
      title: params.title,
      description: params.description,
      slot: params.slot,
      price: params.price,
      address: params.address,
      activityDate: params.activityDate,
      startTime: params.startTime,
      endTime: params.endTime,
      mapUrl: params.mapUrl,
    );
  }
}
