import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/transaction_repository.dart';

class UpdateStatusParams {
  final int id;
  final String status;

  const UpdateStatusParams({
    required this.id,
    required this.status,
  });
}

@injectable
class UpdateStatusUseCase {
  final TransactionRepository repository;

  const UpdateStatusUseCase(this.repository);

  Future<Either<Failure, String>> call(
      UpdateStatusParams params) async {
    if (params.id <= 0) {
      return Left(ValidationFailure(
        message: 'Invalid transaction ID',
        code: 'INVALID_ID',
      ));
    }

    if (params.status.isEmpty) {
      return Left(ValidationFailure(
        message: 'Status cannot be empty',
        code: 'INVALID_STATUS',
      ));
    }

    return await repository.updateStatus(
      id: params.id,
      status: params.status,
    );
  }
}
