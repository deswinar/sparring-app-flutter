import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_sparring/features/location/domain/entities/province_entity.dart';
import 'package:flutter_sparring/features/location/domain/entities/city_entity.dart';
import 'package:flutter_sparring/features/location/presentation/blocs/location_cubit.dart';

// Usage
// LocationSelector(
//   provinceLabel: 'Select Province',
//   cityLabel: 'Select City',
//   allowMultipleCities: true,
//   onProvinceSelected: (p) {},
//   onCitiesSelected: (cities) {},
// )

class LocationSelector extends StatelessWidget {
  final String provinceLabel;
  final String cityLabel;
  final bool allowMultipleCities;
  final void Function(ProvinceEntity?)? onProvinceSelected;
  final void Function(List<CityEntity>)? onCitiesSelected;

  const LocationSelector({
    super.key,
    this.provinceLabel = 'Select Province',
    this.cityLabel = 'Select City',
    this.allowMultipleCities = true,
    this.onProvinceSelected,
    this.onCitiesSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Province Dropdown (single select)
            DropdownSearch<ProvinceEntity>(
              selectedItem: state.selectedProvince,
              items: (filter, _) async {
                // we already have provinces in state, but could be loaded async
                return state.provinces;
              },
              itemAsString: (p) => p.name,
              compareFn: (p1, p2) => p1.id == p2.id,
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  labelText: provinceLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              popupProps: const PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    labelText: 'Search Province',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              onChanged: (province) {
                if (province != null) {
                  context.read<LocationCubit>().selectProvince(province);
                  context.read<LocationCubit>().loadCitiesByProvince(
                        provinceId: province.id,
                      );
                  onProvinceSelected?.call(province);
                }
              },
            ),

            const SizedBox(height: 16),

            /// City Selector (shown only if province is selected)
            if (state.selectedProvince != null) ...[

              if (allowMultipleCities)
                DropdownSearch<CityEntity>.multiSelection(
                  selectedItems: state.selectedCities,
                  items: (filter, _) async {
                    return state.cities;
                  },
                  itemAsString: (c) => c.name,
                  compareFn: (c1, c2) => c1.id == c2.id,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      labelText: cityLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  popupProps: const PopupPropsMultiSelection.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        labelText: 'Search City',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  onChanged: (cities) {
                    // replace selectedCities directly
                    for (final city in state.cities) {
                      if (cities.contains(city) !=
                          state.selectedCities.contains(city)) {
                        context.read<LocationCubit>().toggleCitySelection(city);
                      }
                    }
                    onCitiesSelected?.call(cities);
                  },
                )
              else
                DropdownSearch<CityEntity>(
                  selectedItem: state.selectedCities.isNotEmpty
                      ? state.selectedCities.first
                      : null,
                  items: (filter, _) async {
                    return state.cities;
                  },
                  itemAsString: (c) => c.name,
                  compareFn: (c1, c2) => c1.id == c2.id,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      labelText: cityLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        labelText: 'Search City',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  onChanged: (city) {
                    if (city != null) {
                      context.read<LocationCubit>().toggleCitySelection(city);
                      onCitiesSelected?.call([city]);
                    }
                  },
                ),
            ],
          ],
        );
      },
    );
  }
}
