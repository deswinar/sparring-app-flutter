abstract class AppException implements Exception {
  final String message;
  final String code;
  final int? statusCode; // optional HTTP status code
  final String? path;    // which endpoint caused it
  final dynamic details; // optional raw details for debugging

  const AppException({
    required this.message,
    required this.code,
    this.statusCode,
    this.path,
    this.details,
  });

  @override
  String toString() =>
      '$runtimeType(message: $message, code: $code, status: $statusCode, path: $path, details: $details)';
}

// ---------- Specialized Exceptions ----------

class ServerException extends AppException {
  const ServerException({
    required super.message,
    required super.code,
    super.statusCode,
    super.path,
    super.details,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    required super.code,
    super.statusCode,
    super.path,
    super.details,
  });
}

class CacheException extends AppException {
  const CacheException({
    required super.message,
    required super.code,
    super.details,
  });
}

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    required super.code,
    super.statusCode,
    super.path,
    super.details,
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.code = 'UNAUTHORIZED',
    super.statusCode = 401,
    super.path,
    super.details,
  });
}

class TokenExpiredException extends AppException {
  const TokenExpiredException({
    super.message = 'Token has expired',
    super.code = 'TOKEN_EXPIRED',
    super.statusCode = 401,
    super.path,
    super.details,
  });
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'Forbidden',
    super.code = 'FORBIDDEN',
    super.statusCode = 403,
    super.path,
    super.details,
  });
}

class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
    super.statusCode = 404,
    super.path,
    super.details,
  });
}

class ConflictException extends AppException {
  const ConflictException({
    super.message = 'Conflict occurred',
    super.code = 'CONFLICT',
    super.statusCode = 409,
    super.path,
    super.details,
  });
}

class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.code = 'UNKNOWN',
    super.statusCode,
    super.path,
    super.details,
  });
}
