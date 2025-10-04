import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/bloc/app_bloc_observer.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/province_entity.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/usecases/get_provinces_usecase.dart';
import '../../domain/usecases/get_cities_usecase.dart';
import '../../domain/usecases/get_cities_by_province_usecase.dart';

part 'location_state.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final GetProvincesUseCase _getProvincesUseCase;
  final GetCitiesUseCase _getCitiesUseCase;
  final GetCitiesByProvinceUseCase _getCitiesByProvinceUseCase;

  LocationCubit(
    this._getProvincesUseCase,
    this._getCitiesUseCase,
    this._getCitiesByProvinceUseCase,
  ) : super(const LocationState());

  Future<void> loadProvinces({int page = 1, int perPage = 10}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getProvincesUseCase(
      GetProvincesParams(page: page, perPage: perPage),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
        errorCode: failure.code,
      )),
      (provinces) => emit(state.copyWith(
        isLoading: false,
        provinces: provinces,
        errorMessage: null,
        errorCode: null,
      )),
    );
  }

  Future<void> loadCities({
    int provinceId = 0,
    int page = 1,
    int perPage = 10,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getCitiesUseCase(
      GetCitiesParams(provinceId: provinceId, page: page, perPage: perPage),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
        errorCode: failure.code,
      )),
      (cities) => emit(state.copyWith(
        isLoading: false,
        cities: cities,
        errorMessage: null,
        errorCode: null,
      )),
    );
  }

  Future<void> loadCitiesByProvince({
    required int provinceId,
    int page = 1,
    int perPage = 10,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getCitiesByProvinceUseCase(
      GetCitiesByProvinceParams(
        provinceId: provinceId,
        page: page,
        perPage: perPage,
      ),
    );

    logger.i('loadCitiesByProvince: cities = ${state.cities}');

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
        errorCode: failure.code,
      )),
      (cities) => emit(state.copyWith(
        isLoading: false,
        cities: cities,
        errorMessage: null,
        errorCode: null,
      )),
    );
  }

  /// Single select province
  void selectProvince(ProvinceEntity province) {
    emit(state.copyWith(
      selectedProvince: province,
      selectedCities: [], // reset city selection when province changes
    ));
  }

  /// Multi-select toggle for cities
  void toggleCitySelection(CityEntity city) {
    final updatedCities = List<CityEntity>.from(state.selectedCities);
    if (updatedCities.contains(city)) {
      updatedCities.remove(city);
    } else {
      updatedCities.add(city);
    }
    emit(state.copyWith(selectedCities: updatedCities));
  }

  /// Clear only error
  void clearError() {
    emit(state.copyWith(errorMessage: null, errorCode: null));
  }

  /// Reset everything
  void reset() {
    emit(const LocationState());
  }
}
