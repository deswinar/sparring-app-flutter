import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/validators.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    // Validate input
    final emailValidation = Validators.validateEmail(params.email);
    if (emailValidation != null) {
      return Left(ValidationFailure(
        message: emailValidation,
        code: 'INVALID_EMAIL',
      ));
    }

    final passwordValidation = Validators.validatePassword(params.password);
    if (passwordValidation != null) {
      return Left(ValidationFailure(
        message: passwordValidation,
        code: 'INVALID_PASSWORD',
      ));
    }

    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}