import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_sparring/features/file_upload/domain/usecases/upload_image_usecase.dart';
import 'package:flutter_sparring/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter_sparring/features/transaction/domain/usecases/create_transaction_usecase.dart';
import 'package:flutter_sparring/features/transaction/domain/usecases/update_proof_payment_usecase.dart';
import 'package:flutter_sparring/features/transaction/domain/usecases/update_status_usecase.dart';

part 'upload_proof_payment_state.dart';

@injectable
class UploadProofPaymentCubit extends Cubit<UploadProofPaymentState> {
  final CreateTransactionUseCase createTransactionUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final UpdateProofPaymentUseCase updateProofPaymentUseCase;
  final UpdateStatusUseCase updateStatusUseCase;

  UploadProofPaymentCubit(
    this.createTransactionUseCase,
    this.uploadImageUseCase,
    this.updateProofPaymentUseCase,
    this.updateStatusUseCase,
  ) : super(const UploadProofPaymentInitial());

  /// Full payment process: create → upload image → update proof → simulate update status
  Future<void> processPayment({
    required int sportActivityId,
    required int paymentMethodId,
    required File proofFile,
  }) async {
    emit(const UploadProofPaymentLoading());

    // 1️. Create Transaction
    final createResult = await createTransactionUseCase(
      CreateTransactionParams(
        sportActivityId: sportActivityId,
        paymentMethodId: paymentMethodId,
      ),
    );

    await createResult.fold(
      (failure) async {
        emit(UploadProofPaymentError('Failed to create transaction: ${failure.message}'));
      },
      (transaction) async {
        // 2️. Upload Image
        final uploadResult = await uploadImageUseCase(
          UploadImageParams(file: proofFile),
        );

        await uploadResult.fold(
          (failure) async {
            emit(UploadProofPaymentError('Failed to upload image: ${failure.message}'));
          },
          (uploadEntity) async {
            // 3️. Update Proof Payment
            final proofResult = await updateProofPaymentUseCase(
              UpdateProofPaymentParams(
                id: transaction.id,
                proofPaymentUrl: uploadEntity.url,
              ),
            );

            await proofResult.fold(
              (failure) async => emit(UploadProofPaymentError('Failed to update proof: ${failure.message}')),
              (_) async {
                // 4️. Update Transaction Status to "success"
                final statusResult = await updateStatusUseCase(
                  UpdateStatusParams(id: transaction.id, status: "success"),
                );

                statusResult.fold(
                  (failure) => emit(UploadProofPaymentError('Failed to update status: ${failure.message}')),
                  (_) {
                    final updatedTransaction = transaction.copyWith(
                      proofPaymentUrl: uploadEntity.url,
                      status: "success",
                    );
                    emit(UploadProofPaymentSuccess(updatedTransaction));
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void reset() => emit(const UploadProofPaymentInitial());
}
