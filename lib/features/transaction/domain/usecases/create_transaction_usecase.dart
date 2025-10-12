import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class CreateTransactionParams {
  final int sportActivityId;
  final int paymentMethodId;

  const CreateTransactionParams({
    required this.sportActivityId,
    required this.paymentMethodId,
  });
}

@injectable
class CreateTransactionUseCase {
  final TransactionRepository repository;

  const CreateTransactionUseCase(this.repository);

  Future<Either<Failure, TransactionEntity>> call(
      CreateTransactionParams params) async {
    if (params.sportActivityId <= 0 || params.paymentMethodId <= 0) {
      return Left(ValidationFailure(
        message: 'Invalid sportActivityId or paymentMethodId',
        code: 'INVALID_PARAMS',
      ));
    }

    return await repository.createTransaction(
      sportActivityId: params.sportActivityId,
      paymentMethodId: params.paymentMethodId,
    );
  }
}
