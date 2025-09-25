import 'package:injectable/injectable.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser();
  Future<void> clearUser();
  Future<bool> isLoggedIn();
  Future<void> setLoggedIn(bool loggedIn);
  Future<void> clearAll();
}

@Singleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService _storageService;

  const AuthLocalDataSourceImpl(this._storageService);

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storageService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storageService.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storageService.getRefreshToken();
  }

  @override
  Future<void> clearTokens() async {
    await _storageService.clearTokens();
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    await _storageService.saveUser(user);
  }

  @override
  Future<UserEntity?> getUser() async {
    return await _storageService.getUser();
  }

  @override
  Future<void> clearUser() async {
    await _storageService.clearUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _storageService.isLoggedIn();
  }

  @override
  Future<void> setLoggedIn(bool loggedIn) async {
    await _storageService.setLoggedIn(loggedIn);
  }

  @override
  Future<void> clearAll() async {
    await _storageService.clearAll();
  }
}