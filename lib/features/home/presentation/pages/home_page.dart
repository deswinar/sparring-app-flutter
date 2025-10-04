// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/location/presentation/blocs/location_cubit.dart';
import 'package:flutter_sparring/features/location/presentation/widgets/location_selector.dart';
import 'package:flutter_sparring/features/sport_category/presentation/blocs/sport_category_cubit.dart';
import 'package:flutter_sparring/features/sport_category/presentation/widgets/sport_category_selector.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<LocationCubit>()..loadProvinces(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<SportCategoryCubit>()..loadCategories(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("🏠 Home Test Page")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "📊 Home with some dummy stats",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              /// Location Selector
              LocationSelector(
                provinceLabel: 'Select Province',
                cityLabel: 'Select City',
                allowMultipleCities: false,
                onProvinceSelected: (province) {
                  debugPrint("✅ Province selected: ${province?.name}");
                },
                onCitiesSelected: (cities) {
                  debugPrint(
                      "✅ Cities selected: ${cities.map((c) => c.name).join(', ')}");
                },
              ),

              const SizedBox(height: 24),

              /// Sport Category Selector
              Text(
                "⚽ Sport Categories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              SportCategorySelector(
                onSelected: (id) {
                  debugPrint("✅ Sport category selected: $id");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
