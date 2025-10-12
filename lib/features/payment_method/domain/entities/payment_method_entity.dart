import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  final int id;
  final String? name;
  final String? virtualAccountNumber;
  final String? virtualAccountName;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PaymentMethodEntity({
    required this.id,
    this.name,
    this.virtualAccountNumber,
    this.virtualAccountName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        virtualAccountNumber,
        virtualAccountName,
        imageUrl,
        createdAt,
        updatedAt,
      ];
}

