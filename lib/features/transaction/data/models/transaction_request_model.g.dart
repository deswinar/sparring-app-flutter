// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRequestModel _$TransactionRequestModelFromJson(
  Map<String, dynamic> json,
) => TransactionRequestModel(
  sportActivityId: (json['sport_activity_id'] as num).toInt(),
  paymentMethodId: (json['payment_method_id'] as num).toInt(),
);

Map<String, dynamic> _$TransactionRequestModelToJson(
  TransactionRequestModel instance,
) => <String, dynamic>{
  'sport_activity_id': instance.sportActivityId,
  'payment_method_id': instance.paymentMethodId,
};
