import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/validators.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    // Validate input
    final nameValidation = Validators.validateName(params.name);
    if (nameValidation != null) {
      return Left(ValidationFailure(
        message: nameValidation,
        code: 'INVALID_NAME',
      ));
    }

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

    return await _repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}