import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';
import 'package:flutter_sparring/features/sport_activity/domain/usecases/get_sport_activities_usecase.dart';
import 'package:injectable/injectable.dart';

part 'sport_activity_state.dart';

@injectable
class SportActivityCubit extends Cubit<SportActivityState> {
  final GetSportActivitiesUseCase _getSportActivities;

  SportActivityCubit(this._getSportActivities)
      : super(const SportActivityInitial());

  Future<void> loadActivities({
    GetSportActivitiesParams params = const GetSportActivitiesParams(),
    bool refresh = false,
  }) async {
    if (refresh) emit(const SportActivityRefreshing());

    // keep old state if pagination
    if (state is SportActivityLoading || state is SportActivityRefreshing) {
      return;
    }

    if (!refresh) emit(const SportActivityLoading());

    final result = await _getSportActivities(params);

    result.fold(
      (failure) => emit(SportActivityError(failure)),
      (activities) => emit(SportActivityLoaded(
        activities: activities,
        hasMore: activities.length >= params.perPage,
        currentPage: params.page,
      )),
    );
  }

  Future<void> loadMore(GetSportActivitiesParams params) async {
    if (state is! SportActivityLoaded) return;
    final current = state as SportActivityLoaded;

    // prevent double loading
    if (current.isLoadingMore) return;

    emit(current.copyWith(isLoadingMore: true));

    final nextParams =
        GetSportActivitiesParams(
          page: current.currentPage + 1,
          perPage: params.perPage,
          search: params.search,
          sportCategoryId: params.sportCategoryId,
          cityId: params.cityId,
        );

    final result = await _getSportActivities(nextParams);

    result.fold(
      (failure) => emit(SportActivityError(failure)),
      (activities) => emit(current.copyWith(
        activities: [...current.activities, ...activities],
        currentPage: nextParams.page,
        hasMore: activities.length >= params.perPage,
        isLoadingMore: false,
      )),
    );
  }

  void reset() => emit(const SportActivityInitial());
}
