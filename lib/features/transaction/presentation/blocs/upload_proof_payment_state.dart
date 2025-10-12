part of 'upload_proof_payment_cubit.dart';

abstract class UploadProofPaymentState extends Equatable {
  const UploadProofPaymentState();

  @override
  List<Object?> get props => [];
}

class UploadProofPaymentInitial extends UploadProofPaymentState {
  const UploadProofPaymentInitial();
}

class UploadProofPaymentLoading extends UploadProofPaymentState {
  const UploadProofPaymentLoading();
}

class UploadProofPaymentSuccess extends UploadProofPaymentState {
  final TransactionEntity transaction;

  const UploadProofPaymentSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class UploadProofPaymentError extends UploadProofPaymentState {
  final String message;

  const UploadProofPaymentError(this.message);

  @override
  List<Object?> get props => [message];
}
