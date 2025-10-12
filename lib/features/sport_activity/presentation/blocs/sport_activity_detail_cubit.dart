import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/usecases/get_sport_activity_by_id_usecase.dart';
import 'package:injectable/injectable.dart';

part 'sport_activity_detail_state.dart';

@injectable
class SportActivityDetailCubit extends Cubit<SportActivityDetailState> {
  final GetSportActivityByIdUseCase _getById;

  SportActivityDetailCubit(this._getById)
      : super(const SportActivityDetailInitial());

  Future<void> loadActivity({required GetSportActivityByIdParams params}) async {
    emit(const SportActivityDetailLoading());

    final result = await _getById(params);

    result.fold(
      (failure) => emit(SportActivityDetailError(failure)),
      (activity) => emit(SportActivityDetailLoaded(activity)),
    );
  }

  void reset() => emit(const SportActivityDetailInitial());
}
