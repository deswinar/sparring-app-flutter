part of 'sport_activity_detail_cubit.dart';

abstract class SportActivityDetailState extends Equatable {
  const SportActivityDetailState();

  @override
  List<Object?> get props => [];
}

class SportActivityDetailInitial extends SportActivityDetailState {
  const SportActivityDetailInitial();
}

class SportActivityDetailLoading extends SportActivityDetailState {
  const SportActivityDetailLoading();
}

class SportActivityDetailLoaded extends SportActivityDetailState {
  final SportActivityEntity activity;
  const SportActivityDetailLoaded(this.activity);

  @override
  List<Object?> get props => [activity];
}

class SportActivityDetailError extends SportActivityDetailState {
  final Failure failure;
  const SportActivityDetailError(this.failure);

  @override
  List<Object?> get props => [failure];
}
