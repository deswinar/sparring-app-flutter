import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, required super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.code});
}

class FormatFailure extends Failure {
  const FormatFailure({required super.message, required super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, required super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized access',
    super.code = 'UNAUTHORIZED',
  });
}

class TokenExpiredFailure extends Failure {
  const TokenExpiredFailure({
    super.message = 'Token has expired',
    super.code = 'TOKEN_EXPIRED',
  });
}