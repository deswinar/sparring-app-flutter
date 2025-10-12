part of 'payment_method_cubit.dart';

abstract class PaymentMethodState extends Equatable {
  const PaymentMethodState();

  @override
  List<Object?> get props => [];
}

class PaymentMethodInitial extends PaymentMethodState {
  const PaymentMethodInitial();
}

class PaymentMethodLoading extends PaymentMethodState {
  const PaymentMethodLoading();
}

class PaymentMethodLoaded extends PaymentMethodState {
  final List<PaymentMethodEntity> methods;
  final PaymentMethodEntity? selected;

  const PaymentMethodLoaded(this.methods, {this.selected});

  @override
  List<Object?> get props => [methods, selected];

  PaymentMethodLoaded copyWith({
    List<PaymentMethodEntity>? methods,
    PaymentMethodEntity? selected,
  }) {
    return PaymentMethodLoaded(
      methods ?? this.methods,
      selected: selected ?? this.selected,
    );
  }
}

class PaymentMethodError extends PaymentMethodState {
  final String message;

  const PaymentMethodError(this.message);

  @override
  List<Object?> get props => [message];
}
