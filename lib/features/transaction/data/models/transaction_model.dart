import 'package:flutter_sparring/features/transaction/data/models/transaction_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_sparring/features/transaction/domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TransactionModel {
  final int id;

  final int userId;

  final int? paymentMethodId;

  final String? invoiceId;

  final String? status;

  final int? totalAmount;

  final String? proofPaymentUrl;

  final String? orderDate;

  final String? expiredDate;

  final String? createdAt;

  final String? updatedAt;

  @JsonKey(name: 'transaction_items')
  final TransactionItemModel? transactionItem;

  const TransactionModel({
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

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  TransactionEntity toEntity() => TransactionEntity(
        id: id,
        userId: userId,
        paymentMethodId: paymentMethodId,
        invoiceId: invoiceId,
        status: status,
        totalAmount: totalAmount,
        proofPaymentUrl: proofPaymentUrl,
        orderDate: orderDate != null ? DateTime.tryParse(orderDate!) : null,
        expiredDate: expiredDate != null ? DateTime.tryParse(expiredDate!) : null,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
        updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
        transactionItem: transactionItem?.toEntity(),
      );
}