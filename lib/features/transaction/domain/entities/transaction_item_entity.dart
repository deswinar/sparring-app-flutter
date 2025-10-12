import 'package:equatable/equatable.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';

class TransactionItemEntity extends Equatable {
  final int id;
  final int? transactionId;
  final int? sportActivityId;
  final String? title;
  final int? price;
  final int? priceDiscount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SportActivityEntity? sportActivity;

  const TransactionItemEntity({
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

  @override
  List<Object?> get props => [
        id,
        transactionId,
        sportActivityId,
        title,
        price,
        priceDiscount,
        createdAt,
        updatedAt,
        sportActivity,
      ];
}
