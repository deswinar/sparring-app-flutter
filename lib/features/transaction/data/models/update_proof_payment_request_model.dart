import 'package:json_annotation/json_annotation.dart';

part 'update_proof_payment_request_model.g.dart';

@JsonSerializable()
class UpdateProofPaymentRequestModel {
  @JsonKey(name: 'proof_payment_url')
  final String proofPaymentUrl;

  const UpdateProofPaymentRequestModel({required this.proofPaymentUrl});

  factory UpdateProofPaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProofPaymentRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProofPaymentRequestModelToJson(this);
}
