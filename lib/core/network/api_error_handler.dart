import 'dart:io';
import 'package:dio/dio.dart';
import '../errors/exceptions.dart';

class ApiErrorHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode;
      final path = error.requestOptions.path;
      final details = response?.data ?? error.message;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return NetworkException(
            message: 'Connection timeout',
            code: 'TIMEOUT',
            path: path,
          );

        case DioExceptionType.badResponse:
          final message = response?.data['message'] ??
              error.message ??
              'Unknown server error';

          switch (statusCode) {
            case 400:
              return ValidationException(
                message: message,
                code: 'BAD_REQUEST',
                statusCode: statusCode,
                path: path,
                details: details,
              );
            case 401:
              // Distinguish between expired and unauthorized
              if (message.toString().toLowerCase().contains('expired')) {
                return TokenExpiredException(
                  message: message,
                  path: path,
                  details: details,
                );
              }
              return UnauthorizedException(path: path, details: details);
            case 403:
              return ForbiddenException(path: path, details: details);
            case 404:
              return NotFoundException(path: path, details: details);
            case 409:
              return ConflictException(path: path, details: details);
            case 500:
              return ServerException(
                message: message,
                code: 'SERVER_ERROR',
                statusCode: statusCode,
                path: path,
                details: details,
              );
            default:
              return ServerException(
                message: message,
                code: 'HTTP_$statusCode',
                statusCode: statusCode,
                path: path,
                details: details,
              );
          }

        case DioExceptionType.cancel:
          return NetworkException(
            message: 'Request cancelled',
            code: 'CANCELLED',
            path: path,
          );

        case DioExceptionType.unknown:
        default:
          if (error.error is SocketException) {
            return NetworkException(
              message: 'No Internet connection',
              code: 'NO_INTERNET',
              path: path,
            );
          }
          return UnknownException(
            message: error.message ?? 'Unexpected error',
            statusCode: statusCode,
            path: path,
            details: details,
          );
      }
    }

    // Directly return if already mapped
    if (error is AppException) return error;

    // Fallback for totally unexpected cases
    return UnknownException(
      message: error.toString(),
      code: 'UNEXPECTED',
    );
  }
}
