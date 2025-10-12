import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PaymentMethodModel {
  final int id;
  final String? name;
  final String? virtualAccountNumber;
  final String? virtualAccountName;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PaymentMethodModel({
    required this.id,
    this.name,
    this.virtualAccountNumber,
    this.virtualAccountName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);

  PaymentMethodEntity toEntity() => PaymentMethodEntity(
      id: id,
      name: name,
      virtualAccountNumber: virtualAccountNumber,
      virtualAccountName: virtualAccountName,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }