import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/core/errors/failure_mapper.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_datasource.dart';
import '../models/transaction_request_model.dart';
import '../models/update_proof_payment_request_model.dart';
import '../models/update_status_request_model.dart';

@LazySingleton(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource _remote;

  const TransactionRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions({
    int page = 1,
    int perPage = 5,
    String? search,
  }) async {
    try {
      final response = await _remote.getAllTransactions(
        isPaginate: true,
        perPage: perPage,
        page: page,
        search: search,
      );
      return Right(response.result.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getMyTransactions({
    int page = 1,
    int perPage = 5,
    String? search,
  }) async {
    try {
      final response = await _remote.getMyTransactions(
        isPaginate: true,
        perPage: perPage,
        page: page,
        search: search,
      );
      return Right(response.result.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> getTransactionById(int id) async {
    try {
      final response = await _remote.getTransactionById(id);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> createTransaction({
    required int sportActivityId,
    required int paymentMethodId,
  }) async {
    try {
      final request = TransactionRequestModel(
        sportActivityId: sportActivityId,
        paymentMethodId: paymentMethodId,
      );
      final response = await _remote.createTransaction(request);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, String>> updateProofPayment({
    required int id,
    required String proofPaymentUrl,
  }) async {
    try {
      final request = UpdateProofPaymentRequestModel(proofPaymentUrl: proofPaymentUrl);
      final response = await _remote.updateProofPayment(id, request);

      // handle backend message response
      if (response.error) {
        return Left(ServerFailure(message: response.message, code: 'SERVER_ERROR'));
      }

      return Right(response.message);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, String>> updateStatus({
    required int id,
    required String status,
  }) async {
    try {
      final request = UpdateStatusRequestModel(status: status);
      final response = await _remote.updateStatus(id, request);

      // handle backend message response
      if (response.error) {
        return Left(ServerFailure(message: response.message, code: 'SERVER_ERROR'));
      }

      return Right(response.message);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> cancelTransaction({
    required int id,
    required String status,
  }) async {
    try {
      final request = UpdateStatusRequestModel(status: status);
      final response = await _remote.cancelTransaction(id, request);
      return Right(response.result.toEntity());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}
