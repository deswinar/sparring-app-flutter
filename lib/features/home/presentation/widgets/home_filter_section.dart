import 'package:flutter/material.dart';
import 'package:flutter_sparring/features/location/presentation/widgets/location_selector.dart';
import 'package:flutter_sparring/features/sport_category/presentation/widgets/sport_category_selector.dart';

class HomeFilterSection extends StatelessWidget {
  final Function(int?) onCitySelected;
  final Function(int?) onCategorySelected;

  const HomeFilterSection({
    super.key,
    required this.onCitySelected,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 72, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("📍 Location", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          LocationSelector(
            provinceLabel: 'Select Province',
            cityLabel: 'Select City',
            allowMultipleCities: false,
            onProvinceSelected: (_) {
              onCitySelected(null);
            },
            onCitiesSelected: (cities) {
              final cityId = cities.isNotEmpty ? cities.first.id : null;
              onCitySelected(cityId);
            },
          ),
          const SizedBox(height: 20),
          Text("⚽ Sport Categories", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SportCategorySelector(
            onSelected: onCategorySelected,
          ),
        ],
      ),
    );
  }
}
