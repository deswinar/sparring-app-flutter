part of 'sport_activity_cubit.dart';

abstract class SportActivityState extends Equatable {
  const SportActivityState();

  @override
  List<Object?> get props => [];
}

class SportActivityInitial extends SportActivityState {
  const SportActivityInitial();
}

class SportActivityLoading extends SportActivityState {
  const SportActivityLoading();
}

class SportActivityRefreshing extends SportActivityState {
  const SportActivityRefreshing();
}

class SportActivityLoaded extends SportActivityState {
  final List<SportActivityEntity> activities;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  const SportActivityLoaded({
    required this.activities,
    required this.currentPage,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [activities, currentPage, hasMore, isLoadingMore];

  SportActivityLoaded copyWith({
    List<SportActivityEntity>? activities,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return SportActivityLoaded(
      activities: activities ?? this.activities,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class SportActivityError extends SportActivityState {
  final Failure failure;

  const SportActivityError(this.failure);

  @override
  List<Object?> get props => [failure];
}
