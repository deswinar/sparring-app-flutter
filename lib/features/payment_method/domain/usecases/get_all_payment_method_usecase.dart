import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:flutter_sparring/features/payment_method/domain/repositories/payment_method_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';

@injectable
class GetAllPaymentMethodUseCase {
  final PaymentMethodRepository repository;

  const GetAllPaymentMethodUseCase(this.repository);

  Future<Either<Failure, List<PaymentMethodEntity>>> call() async {
    return await repository.getAllPaymentMethods();
  }
}
