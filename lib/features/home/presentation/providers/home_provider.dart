import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/di/injection.dart';
import 'package:flutter_sparring/features/location/presentation/blocs/location_cubit.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/blocs/sport_activity_cubit.dart';
import 'package:flutter_sparring/features/sport_category/presentation/blocs/sport_category_cubit.dart';

class HomeProviders extends StatelessWidget {
  final Widget child;

  const HomeProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LocationCubit>()..loadProvinces()),
        BlocProvider(create: (_) => getIt<SportCategoryCubit>()..loadCategories()),
        BlocProvider(create: (_) => getIt<SportActivityCubit>()..loadActivities()),
      ],
      child: child,
    );
  }
}
