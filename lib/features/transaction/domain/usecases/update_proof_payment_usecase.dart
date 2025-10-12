import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/transaction_repository.dart';

class UpdateProofPaymentParams {
  final int id;
  final String proofPaymentUrl;

  const UpdateProofPaymentParams({
    required this.id,
    required this.proofPaymentUrl,
  });
}

@injectable
class UpdateProofPaymentUseCase {
  final TransactionRepository repository;

  const UpdateProofPaymentUseCase(this.repository);

  Future<Either<Failure, String>> call(UpdateProofPaymentParams params) async {
    // Validation layer
    if (params.id <= 0) {
      return Left(ValidationFailure(
        message: 'Invalid transaction ID',
        code: 'INVALID_ID',
      ));
    }

    if (params.proofPaymentUrl.isEmpty) {
      return Left(ValidationFailure(
        message: 'Proof payment URL cannot be empty',
        code: 'INVALID_PROOF_URL',
      ));
    }

    // Call repository
    return await repository.updateProofPayment(
      id: params.id,
      proofPaymentUrl: params.proofPaymentUrl,
    );
  }
}
