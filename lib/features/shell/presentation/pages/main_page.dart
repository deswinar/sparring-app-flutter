import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/routing/app_router.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_routes.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          LoginRoute().go(context);
        }
      },
      child: Scaffold(
        body: child,
        bottomNavigationBar: _MainBottomNav(),
      ),
    );
  }
}

class _MainBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith(AppRoutes.search)) currentIndex = 1;
    if (location.startsWith(AppRoutes.bookings)) currentIndex = 2;
    if (location.startsWith(AppRoutes.messages)) currentIndex = 3;
    if (location.startsWith(AppRoutes.profile)) currentIndex = 4;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.home);
            break;
          case 1:
            context.go(AppRoutes.search);
            break;
          case 2:
            context.go(AppRoutes.bookings);
            break;
          case 3:
            context.go(AppRoutes.messages);
            break;
          case 4:
            context.go(AppRoutes.profile);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: "Bookings",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: "Messages",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
