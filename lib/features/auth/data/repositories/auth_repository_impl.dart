import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failure_mapper.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await _remoteDataSource.login(request);

      // Save tokens and user data locally
      await _localDataSource.saveTokens(
        accessToken: response.data.token,
        refreshToken: response.data.token,
      );
      
      // Init user
      UserEntity? user;

      // Fetch user
      final userResponse = await _remoteDataSource.getCurrentUser();
      user = userResponse.data;

      // Save user locally
      await _localDataSource.saveUser(user);

      return Right(user);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final request = RegisterRequestModel(
        name: name,
        email: email,
        password: password,
      );

      final response = await _remoteDataSource.register(request);

      // Save tokens and user data locally
      await _localDataSource.saveTokens(
        accessToken: response.data.token,
        refreshToken: response.data.token,
      );
      // Init user
      UserEntity? user;

      // Fetch user
      final userResponse = await _remoteDataSource.getCurrentUser();
      user = userResponse.data;

      // Save user locally
      await _localDataSource.saveUser(user);

      return Right(user);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Try to logout on server first
      try {
        await _remoteDataSource.logout();
      } catch (e) {
        // Continue with local logout even if server logout fails
      }

      // Clear local data
      await _localDataSource.clearAll();

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(
        message: 'Failed to logout: ${e.toString()}',
        code: 'LOGOUT_ERROR',
      ));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final isLoggedIn = await _localDataSource.isLoggedIn();
      if (!isLoggedIn) {
        return const Right(null);
      }

      // Try to get user from local storage first
      final localUser = await _localDataSource.getUser();
      if (localUser != null) {
        return Right(localUser);
      }

      // If no local user, try to fetch from server
      final remoteUser = await _remoteDataSource.getCurrentUser();
      await _localDataSource.saveUser(remoteUser.data);
      
      return Right(remoteUser.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      if (exception is UnauthorizedException ||
          exception is TokenExpiredException) {
        await _localDataSource.clearAll();
        return const Right(null);
      }
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final isLoggedIn = await _localDataSource.isLoggedIn();
      final hasToken = await _localDataSource.getAccessToken();
      
      return Right(isLoggedIn && hasToken != null && hasToken.isNotEmpty);
    } catch (e) {
      return Left(CacheFailure(
        message: 'Failed to check login status: ${e.toString()}',
        code: 'CHECK_LOGIN_ERROR',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      final refreshToken = await _localDataSource.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return Left(TokenExpiredFailure());
      }

      final response = await _remoteDataSource.refreshToken({
        'refresh_token': refreshToken,
      });

      await _localDataSource.saveTokens(
        accessToken: response.data.token,
        refreshToken: response.data.token,
      );

      return const Right(null);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      if (exception is UnauthorizedException ||
          exception is TokenExpiredException) {
        await _localDataSource.clearAll();
        return Left(const TokenExpiredFailure());
      }
      return Left(FailureMapper.fromException(exception));
    }
  }
}