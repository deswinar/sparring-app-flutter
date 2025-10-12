import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:flutter_sparring/features/payment_method/domain/usecases/get_all_payment_method_usecase.dart';
import 'package:injectable/injectable.dart';

part 'payment_method_state.dart';

@injectable
class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final GetAllPaymentMethodUseCase getAllPaymentMethodUseCase;

  PaymentMethodCubit(this.getAllPaymentMethodUseCase)
      : super(const PaymentMethodInitial());

  /// Load all available payment methods
  Future<void> loadPaymentMethods() async {
    emit(const PaymentMethodLoading());

    final result = await getAllPaymentMethodUseCase();

    result.fold(
      (failure) => emit(PaymentMethodError(failure.message)),
      (methods) => emit(PaymentMethodLoaded(methods)),
    );
  }

  /// Select a specific payment method (for UI interaction)
  void selectPaymentMethod(PaymentMethodEntity method) {
    if (state is PaymentMethodLoaded) {
      final current = state as PaymentMethodLoaded;
      emit(current.copyWith(selected: method));
    }
  }

  /// Deselect payment method
  void clearSelection() {
    if (state is PaymentMethodLoaded) {
      final current = state as PaymentMethodLoaded;
      emit(current.copyWith(selected: null));
    }
  }
}
