import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/routing/app_router.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:flutter_sparring/shared/widgets/app_loader.dart';
import 'package:flutter_sparring/shared/widgets/app_snackbar.dart';
import 'package:flutter_sparring/features/auth/presentation/widgets/loading_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthUnauthenticated || current is AuthError,
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigate to login and clear stack
          LoginRoute().go(context);
        } else if (state is AuthError) {
          AppSnackbar.show(
            context,
            title: "Something went wrong",
            message: state.message,
            type: SnackbarType.error,
            position: SnackbarPosition.bottom,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state.user;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "👤 Profile",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.person),
                    title: Text(user.name),
                    subtitle: const Text("Name"),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.email),
                    title: Text(user.email),
                    subtitle: const Text("Email"),
                  ),
                  const Spacer(),
                  // Logout button with loading state
                  LoadingButton(
                    text: 'Logout',
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    isLoading: state is AuthLoading,
                  ),
                ],
              ),
            ),
          );
        } else if (state is AuthLoading) {
          // Logging out
          return const AppLoader();
        } else {
          // Default fallback
          return const AppLoader();
        }
      },
    );
  }
}
