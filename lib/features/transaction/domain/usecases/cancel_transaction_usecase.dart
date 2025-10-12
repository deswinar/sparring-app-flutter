import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class CancelTransactionParams {
  final int id;
  final String status;

  const CancelTransactionParams({
    required this.id,
    required this.status,
  });
}

@injectable
class CancelTransactionUseCase {
  final TransactionRepository repository;

  const CancelTransactionUseCase(this.repository);

  Future<Either<Failure, TransactionEntity>> call(
      CancelTransactionParams params) async {
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

    return await repository.cancelTransaction(
      id: params.id,
      status: params.status,
    );
  }
}
