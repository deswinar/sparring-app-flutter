import 'package:dio/dio.dart';
import 'package:flutter_sparring/core/bloc/app_bloc_observer.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage_service.dart';

@singleton
class DioClient {
  late Dio _dio;
  final SecureStorageService _storageService;

  DioClient(this._storageService) {
    _dio = Dio();
    _setupDio();
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        ApiConstants.contentType: ApiConstants.applicationJson,
      },
    );
  }

  void _setupInterceptors() {
    // Add pretty logger in debug mode
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    // Add auth interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logger.i(
      '[API Request] ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Query: ${options.queryParameters}\n'
      'Body: ${options.data}',
    );
    // Add authorization header if token exists
    final token = await _storageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] = 
          '${ApiConstants.bearerToken} $token';
    }
    handler.next(options);
  }

  Future<void> _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    logger.i(
      '[API Response] ${response.statusCode} ${response.requestOptions.uri}\n'
      'Headers: ${response.headers}\n'
      'Body: ${response.data}',
    );
    handler.next(response);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    logger.e(
      '[API Error] ${err.response?.statusCode} ${err.requestOptions.uri}\n'
      'Headers: ${err.response?.headers}\n'
      'Body: ${err.response?.data}',
    );
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the request with new token
        final options = err.requestOptions;
        final token = await _storageService.getAccessToken();
        options.headers[ApiConstants.authorization] = 
            '${ApiConstants.bearerToken} $token';
        
        try {
          final response = await _dio.fetch(options);
          handler.resolve(response);
          return;
        } catch (e) {
          // If retry fails, continue with original error
        }
      }
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        ApiConstants.refreshTokenEndpoint,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await _storageService.saveTokens(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'] ?? refreshToken,
        );
        return true;
      }
    } catch (e) {
      // Clear tokens on refresh failure
      await _storageService.clearTokens();
    }
    return false;
  }
}