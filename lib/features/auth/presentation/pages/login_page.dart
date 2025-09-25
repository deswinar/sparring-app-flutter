import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/routing/app_router.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:flutter_sparring/shared/widgets/app_snackbar.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    debugPrint('handle login');
    debugPrint('form valid: ${_formKey.currentState?.validate()}');
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _navigateToRegister() {
    registerRoute.go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackbar.show(
              context,
              title: "Something went wrong",
              message: state.message,
              type: SnackbarType.error,
              position: SnackbarPosition.bottom,
            );
          }
          if (state is AuthAuthenticated) {
            homeRoute.go(context);
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                // Only scroll when keyboard or small screen forces it
                physics: constraints.maxHeight < 600
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 60),
                                  Text(
                                    'Welcome Back',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Sign in to your account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                  ),
                                  const SizedBox(height: 48),
                                  CustomTextField(
                                    label: 'Email',
                                    hint: 'Enter your email',
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icons.email_outlined,
                                    validator: Validators.validateEmail,
                                  ),
                                  const SizedBox(height: 24),
                                  CustomTextField(
                                    label: 'Password',
                                    hint: 'Enter your password',
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    prefixIcon: Icons.lock_outline,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    validator: Validators.validatePassword,
                                  ),
                                  const SizedBox(height: 32),
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      return LoadingButton(
                                        text: 'Sign In',
                                        onPressed: _handleLogin,
                                        isLoading: state is AuthLoading,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Footer always stays pinned at bottom if space allows
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: _navigateToRegister,
                                    child: const Text('Sign Up'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}