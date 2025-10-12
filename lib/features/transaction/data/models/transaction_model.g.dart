// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      paymentMethodId: (json['payment_method_id'] as num?)?.toInt(),
      invoiceId: json['invoice_id'] as String?,
      status: json['status'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      proofPaymentUrl: json['proof_payment_url'] as String?,
      orderDate: json['order_date'] as String?,
      expiredDate: json['expired_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      transactionItem: json['transaction_items'] == null
          ? null
          : TransactionItemModel.fromJson(
              json['transaction_items'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'payment_method_id': instance.paymentMethodId,
      'invoice_id': instance.invoiceId,
      'status': instance.status,
      'total_amount': instance.totalAmount,
      'proof_payment_url': instance.proofPaymentUrl,
      'order_date': instance.orderDate,
      'expired_date': instance.expiredDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'transaction_items': instance.transactionItem?.toJson(),
    };
