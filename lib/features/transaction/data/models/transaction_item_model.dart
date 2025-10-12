import 'package:flutter_sparring/features/sport_activity/data/models/sport_activity_model.dart';
import 'package:flutter_sparring/features/transaction/domain/entities/transaction_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_item_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TransactionItemModel {
  final int id;

  final int? transactionId;

  final int? sportActivityId;

  final String? title;
  final int? price;

  final int? priceDiscount;

  final String? createdAt;

  final String? updatedAt;

  @JsonKey(name: 'sport_activities')
  final SportActivityModel? sportActivity;

  const TransactionItemModel({
    required this.id,
    this.transactionId,
    this.sportActivityId,
    this.title,
    this.price,
    this.priceDiscount,
    this.createdAt,
    this.updatedAt,
    this.sportActivity,
  });

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemModelToJson(this);

  TransactionItemEntity toEntity() => TransactionItemEntity(
        id: id,
        transactionId: transactionId,
        sportActivityId: sportActivityId,
        title: title,
        price: price,
        priceDiscount: priceDiscount,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
        updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
        sportActivity: sportActivity?.toEntity(),
      );
}