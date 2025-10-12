import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionByIdParams {
  final int id;

  const GetTransactionByIdParams({required this.id});
}

@injectable
class GetTransactionByIdUseCase {
  final TransactionRepository repository;

  const GetTransactionByIdUseCase(this.repository);

  Future<Either<Failure, TransactionEntity>> call(
      GetTransactionByIdParams params) async {
    if (params.id <= 0) {
      return Left(ValidationFailure(
        message: 'Invalid transaction ID',
        code: 'INVALID_ID',
      ));
    }

    return await repository.getTransactionById(params.id);
  }
}
