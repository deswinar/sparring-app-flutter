import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../constants/storage_keys.dart';
import '../../features/auth/domain/entities/user_entity.dart';

abstract class SecureStorageService {
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

@Singleton(as: SecureStorageService)
class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageServiceImpl(this._secureStorage);

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _secureStorage.write(key: StorageKeys.accessToken, value: accessToken),
      _secureStorage.write(key: StorageKeys.refreshToken, value: refreshToken),
      setLoggedIn(true),
    ]);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: StorageKeys.accessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: StorageKeys.refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: StorageKeys.accessToken),
      _secureStorage.delete(key: StorageKeys.refreshToken),
      setLoggedIn(false),
    ]);
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    final userJson = jsonEncode({
      'id': user.id,
      'name': user.name,
      'email': user.email,
    });
    await _secureStorage.write(key: StorageKeys.userProfile, value: userJson);
  }

  @override
  Future<UserEntity?> getUser() async {
    final userJson = await _secureStorage.read(key: StorageKeys.userProfile);
    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserEntity(
        id: userMap['id'] as int,
        name: userMap['name'] as String,
        email: userMap['email'] as String,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearUser() async {
    await _secureStorage.delete(key: StorageKeys.userProfile);
  }

  @override
  Future<bool> isLoggedIn() async {
    final value = await _secureStorage.read(key: StorageKeys.isLoggedIn);
    return value == 'true';
  }

  @override
  Future<void> setLoggedIn(bool loggedIn) async {
    await _secureStorage.write(
      key: StorageKeys.isLoggedIn, 
      value: loggedIn.toString(),
    );
  }

  @override
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}