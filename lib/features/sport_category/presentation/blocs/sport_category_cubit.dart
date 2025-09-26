import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/sport_category/domain/entities/sport_category_entity.dart';
import 'package:flutter_sparring/features/sport_category/domain/usecases/get_sport_categories_usecase.dart';
import 'package:injectable/injectable.dart';

part 'sport_category_state.dart';

@injectable
class SportCategoryCubit extends Cubit<SportCategoryState> {
  final GetSportCategoriesUseCase getSportCategoriesUseCase;

  SportCategoryCubit(this.getSportCategoriesUseCase)
      : super(const SportCategoryInitial());

  Future<void> loadCategories({int page = 1, int perPage = 10}) async {
    emit(const SportCategoryLoading());

    final result = await getSportCategoriesUseCase(
      GetSportCategoriesParams(page: page, perPage: perPage),
    );

    result.fold(
      (failure) => emit(SportCategoryError(failure.message)),
      (categories) => emit(SportCategoryLoaded(categories)),
    );
  }

  void selectCategory(SportCategoryEntity category) {
    if (state is SportCategoryLoaded) {
      final current = state as SportCategoryLoaded;
      emit(current.copyWith(selected: category));
    }
  }
}
