part of 'location_cubit.dart';

class LocationState extends Equatable {
  final bool isLoading;
  final List<ProvinceEntity> provinces;
  final List<CityEntity> cities;
  final ProvinceEntity? selectedProvince;
  final List<CityEntity> selectedCities;
  final String? errorMessage;
  final String? errorCode;

  const LocationState({
    this.isLoading = false,
    this.provinces = const [],
    this.cities = const [],
    this.selectedProvince,
    this.selectedCities = const [],
    this.errorMessage,
    this.errorCode,
  });

  LocationState copyWith({
    bool? isLoading,
    List<ProvinceEntity>? provinces,
    List<CityEntity>? cities,
    ProvinceEntity? selectedProvince,
    List<CityEntity>? selectedCities,
    String? errorMessage,
    String? errorCode,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      provinces: provinces ?? this.provinces,
      cities: cities ?? this.cities,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedCities: selectedCities ?? this.selectedCities,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        provinces,
        cities,
        selectedProvince,
        selectedCities,
        errorMessage,
        errorCode,
      ];
}
