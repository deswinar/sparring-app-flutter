import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class PaymentMethodRepository {
  Future<Either<Failure, List<PaymentMethodEntity>>> getAllPaymentMethods();
}