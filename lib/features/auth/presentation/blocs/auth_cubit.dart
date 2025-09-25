import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/auth/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthCubit(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(const AuthLoading());

    final result = await _getCurrentUserUseCase();
    result.fold(
      (failure) => emit(AuthError(
        message: failure.message,
        code: failure.code,
      )),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final params = LoginParams(
      email: email.trim(),
      password: password,
    );

    final result = await _loginUseCase(params);
    result.fold(
      (failure) => emit(AuthError(
        message: failure.message,
        code: failure.code,
      )),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final params = RegisterParams(
      name: name.trim(),
      email: email.trim(),
      password: password,
    );

    final result = await _registerUseCase(params);
    result.fold(
      (failure) => emit(AuthError(
        message: failure.message,
        code: failure.code,
      )),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());

    final result = await _logoutUseCase();
    result.fold(
      (failure) => emit(AuthError(
        message: failure.message,
        code: failure.code,
      )),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  void clearError() {
    if (state is AuthError) {
      emit(const AuthUnauthenticated());
    }
  }
}