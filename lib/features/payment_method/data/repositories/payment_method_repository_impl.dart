import 'package:flutter_sparring/core/errors/failure_mapper.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';
import 'package:flutter_sparring/features/payment_method/data/datasources/payment_method_remote_datasource.dart';
import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:flutter_sparring/features/payment_method/domain/repositories/payment_method_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentMethodRepository)
class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final PaymentMethodRemoteDataSource _remote;

  const PaymentMethodRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getAllPaymentMethods() async {
    try {
      final response = await _remote.getAllPaymentMethods();
      return Right(response.result.map((e) => e.toEntity()).toList());
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}