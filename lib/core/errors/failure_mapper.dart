import 'exceptions.dart';
import 'failures.dart';

class FailureMapper {
  static Failure fromException(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException _:
        return ServerFailure(
          message: exception.message,
          code: exception.code,
        );
      case NetworkException _:
        return NetworkFailure(
          message: exception.message,
          code: exception.code,
        );
      case CacheException _:
        return CacheFailure(
          message: exception.message,
          code: exception.code,
        );
      case FormatException _:
        return FormatFailure(
          message: exception.message,
          code: exception.code,
        );
      case ValidationException _:
        return ValidationFailure(
          message: exception.message,
          code: exception.code,
        );
      case UnauthorizedException _:
        return const UnauthorizedFailure();
      case TokenExpiredException _:
        return const TokenExpiredFailure();
      default:
        return ServerFailure(
          message: exception.message,
          code: exception.code,
        );
    }
  }
}
