import 'package:json_annotation/json_annotation.dart';

part 'transaction_request_model.g.dart';

@JsonSerializable()
class TransactionRequestModel {
  @JsonKey(name: 'sport_activity_id')
  final int sportActivityId;

  @JsonKey(name: 'payment_method_id')
  final int paymentMethodId;

  const TransactionRequestModel({
    required this.sportActivityId,
    required this.paymentMethodId,
  });

  factory TransactionRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRequestModelToJson(this);
}
