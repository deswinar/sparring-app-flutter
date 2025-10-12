import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions({
    int page = 1,
    int perPage = 5,
    String? search,
  });

  Future<Either<Failure, List<TransactionEntity>>> getMyTransactions({
    int page = 1,
    int perPage = 5,
    String? search,
  });

  Future<Either<Failure, TransactionEntity>> getTransactionById(int id);

  Future<Either<Failure, TransactionEntity>> createTransaction({
    required int sportActivityId,
    required int paymentMethodId,
  });

  Future<Either<Failure, String>> updateProofPayment({
    required int id,
    required String proofPaymentUrl,
  });

  Future<Either<Failure, String>> updateStatus({
    required int id,
    required String status,
  });

  Future<Either<Failure, TransactionEntity>> cancelTransaction({
    required int id,
    required String status,
  });
}
