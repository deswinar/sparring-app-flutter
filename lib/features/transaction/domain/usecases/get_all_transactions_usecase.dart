import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetAllTransactionsParams {
  final int page;
  final int perPage;
  final String? search;

  const GetAllTransactionsParams({
    this.page = 1,
    this.perPage = 5,
    this.search,
  });
}

@injectable
class GetAllTransactionsUseCase {
  final TransactionRepository repository;

  const GetAllTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call(
      GetAllTransactionsParams params) async {
    if (params.page < 1) {
      return Left(ValidationFailure(
        message: 'Page must be greater than 0',
        code: 'INVALID_PAGE',
      ));
    }

    if (params.perPage < 1) {
      return Left(ValidationFailure(
        message: 'PerPage must be greater than 0',
        code: 'INVALID_PER_PAGE',
      ));
    }

    return await repository.getAllTransactions(
      page: params.page,
      perPage: params.perPage,
      search: params.search,
    );
  }
}
