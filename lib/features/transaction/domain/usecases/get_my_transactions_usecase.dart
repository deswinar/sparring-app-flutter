import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetMyTransactionsParams {
  final int page;
  final int perPage;
  final String? search;

  const GetMyTransactionsParams({
    this.page = 1,
    this.perPage = 5,
    this.search,
  });
}

@injectable
class GetMyTransactionsUseCase {
  final TransactionRepository repository;

  const GetMyTransactionsUseCase(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call(
      GetMyTransactionsParams params) async {
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

    return await repository.getMyTransactions(
      page: params.page,
      perPage: params.perPage,
      search: params.search,
    );
  }
}
