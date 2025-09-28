import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_sparring/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_sparring/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_sparring/features/shell/presentation/pages/main_page.dart';

// Feature pages (later move to their feature folders)
import 'package:flutter_sparring/features/home/presentation/pages/home_page.dart';
import 'package:flutter_sparring/features/search/presentation/pages/search_page.dart';
import 'package:flutter_sparring/features/bookings/presentation/pages/bookings_page.dart';
import 'package:flutter_sparring/features/messages/presentation/pages/messages_page.dart';
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
    TypedGoRoute<SearchRoute>(
      path: AppRoutes.search,
    ),
    TypedGoRoute<BookingsRoute>(
      path: AppRoutes.bookings,
    ),
    TypedGoRoute<MessagesRoute>(
      path: AppRoutes.messages,
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
  Widget build(BuildContext context, GoRouterState state) =>
      const HomePage();
}

class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchPage();
}

class BookingsRoute extends GoRouteData with $BookingsRoute {
  const BookingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BookingsPage();
}

class MessagesRoute extends GoRouteData with $MessagesRoute {
  const MessagesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MessagesPage();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

/// Root router
final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: $appRoutes,
  redirect: (context, state) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state is AuthAuthenticated;

    final goingToLogin = state.uri.toString() == AppRoutes.login;

    if (!isLoggedIn && !goingToLogin) {
      return AppRoutes.login; // force redirect to login
    }
    if (isLoggedIn && goingToLogin) {
      return AppRoutes.home; // go to home tab after login
    }

    return null;
  },
);
