// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItemModel _$TransactionItemModelFromJson(
  Map<String, dynamic> json,
) => TransactionItemModel(
  id: (json['id'] as num).toInt(),
  transactionId: (json['transaction_id'] as num?)?.toInt(),
  sportActivityId: (json['sport_activity_id'] as num?)?.toInt(),
  title: json['title'] as String?,
  price: (json['price'] as num?)?.toInt(),
  priceDiscount: (json['price_discount'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  sportActivity: json['sport_activities'] == null
      ? null
      : SportActivityModel.fromJson(
          json['sport_activities'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$TransactionItemModelToJson(
  TransactionItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'transaction_id': instance.transactionId,
  'sport_activity_id': instance.sportActivityId,
  'title': instance.title,
  'price': instance.price,
  'price_discount': instance.priceDiscount,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'sport_activities': instance.sportActivity?.toJson(),
};
