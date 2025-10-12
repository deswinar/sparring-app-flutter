import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:flutter_sparring/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/pages/sport_activity_detail_page.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_sparring/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_sparring/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_sparring/features/shell/presentation/pages/main_page.dart';

// Feature pages
import 'package:flutter_sparring/features/home/presentation/pages/home_page.dart';
import 'package:flutter_sparring/features/bookings/presentation/pages/bookings_page.dart';
import 'package:flutter_sparring/features/profile/presentation/pages/profile_page.dart';

import 'app_routes.dart';

part 'app_router.g.dart';

/// Login
@TypedGoRoute<LoginRoute>(
  path: AppRoutes.login,
)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginPage();
}

/// Register
@TypedGoRoute<RegisterRoute>(
  path: AppRoutes.register,
)
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterPage();
}

/// Shell (MainPage with bottom nav)
@TypedShellRoute<MainShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(
      path: AppRoutes.home,
    ),
    TypedGoRoute<BookingsRoute>(
      path: AppRoutes.bookings,
    ),
    TypedGoRoute<ProfileRoute>(
      path: AppRoutes.profile,
    ),
  ],
)
class MainShellRoute extends ShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MainPage(child: navigator); // `navigator` = active tab child
  }
}

/// Each tab route
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeProviders(
      child: HomePage(),
    );
  }
}

class BookingsRoute extends GoRouteData with $BookingsRoute {
  const BookingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BookingsPage();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

/// Sport Activity Detail Page
@TypedGoRoute<SportActivityDetailRoute>(
  path: AppRoutes.sportActivityDetail,
)
class SportActivityDetailRoute extends GoRouteData with $SportActivityDetailRoute {
  final int id;

  const SportActivityDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SportActivityDetailPage(activityId: id);
  }
}


/// Root router
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: $appRoutes,
  redirect: (context, state) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state is AuthAuthenticated;

    final publicRoutes = [AppRoutes.login, AppRoutes.register];
    final goingToPublic = publicRoutes.contains(state.uri.toString());

    if (!isLoggedIn && !goingToPublic) {
      return AppRoutes.login;
    }
    if (isLoggedIn && goingToPublic) {
      return AppRoutes.home;
    }

    return null;
  },
);
