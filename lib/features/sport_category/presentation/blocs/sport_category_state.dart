part of 'sport_category_cubit.dart';

abstract class SportCategoryState extends Equatable {
  const SportCategoryState();

  @override
  List<Object?> get props => [];
}

class SportCategoryInitial extends SportCategoryState {
  const SportCategoryInitial();
}

class SportCategoryLoading extends SportCategoryState {
  const SportCategoryLoading();
}

class SportCategoryLoaded extends SportCategoryState {
  final List<SportCategoryEntity> categories;
  final SportCategoryEntity? selected;

  const SportCategoryLoaded(this.categories, {this.selected});

  @override
  List<Object?> get props => [categories, selected];

  SportCategoryLoaded copyWith({
    List<SportCategoryEntity>? categories,
    SportCategoryEntity? selected,
  }) {
    return SportCategoryLoaded(
      categories ?? this.categories,
      selected: selected ?? this.selected,
    );
  }
}

class SportCategoryError extends SportCategoryState {
  final String message;

  const SportCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
