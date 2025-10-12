import 'package:equatable/equatable.dart';
import 'package:flutter_sparring/features/transaction/domain/entities/transaction_item_entity.dart';

class TransactionEntity extends Equatable {
  final int id;
  final int userId;
  final int? paymentMethodId;
  final String? invoiceId;
  final String? status;
  final int? totalAmount;
  final String? proofPaymentUrl;
  final DateTime? orderDate;
  final DateTime? expiredDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TransactionItemEntity? transactionItem;

  const TransactionEntity({
    required this.id,
    required this.userId,
    this.paymentMethodId,
    this.invoiceId,
    this.status,
    this.totalAmount,
    this.proofPaymentUrl,
    this.orderDate,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.transactionItem,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        paymentMethodId,
        invoiceId,
        status,
        totalAmount,
        proofPaymentUrl,
        orderDate,
        expiredDate,
        createdAt,
        updatedAt,
        transactionItem,
      ];

  TransactionEntity copyWith({
    int? id,
    int? userId,
    int? paymentMethodId,
    String? invoiceId,
    String? status,
    int? totalAmount,
    String? proofPaymentUrl,
    DateTime? orderDate,
    DateTime? expiredDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    TransactionItemEntity? transactionItem,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      invoiceId: invoiceId ?? this.invoiceId,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      proofPaymentUrl: proofPaymentUrl ?? this.proofPaymentUrl,
      orderDate: orderDate ?? this.orderDate,
      expiredDate: expiredDate ?? this.expiredDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      transactionItem: transactionItem ?? this.transactionItem,
    );
  }
}

