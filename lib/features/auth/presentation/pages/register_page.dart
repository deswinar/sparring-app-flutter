import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/di/injection.dart';
import 'package:flutter_sparring/core/routing/app_router.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:flutter_sparring/shared/widgets/app_snackbar.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              AppSnackbar.show(
                context,
                title: "Something went wrong",
                message: state.message,
                type: SnackbarType.error,
                position: SnackbarPosition.bottom,
              );
            } else if (state is AuthAuthenticated) {
              HomeRoute().go(context);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your details to create an account',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _nameController,
                        label: 'Name',
                        hint: 'Name',
                        validator: Validators.validateName,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'Email',
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Password',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: Validators.validatePassword,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Confirm Password',
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
                      ),
                      const SizedBox(height: 24),
                      LoadingButton(
                        text: 'Register',
                        isEnabled: true,
                        isLoading: false,
                        onPressed: _handleRegister,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}