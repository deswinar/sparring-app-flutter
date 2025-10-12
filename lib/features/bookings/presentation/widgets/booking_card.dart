import 'package:flutter/material.dart';
import 'package:flutter_sparring/core/utils/currency_formatter.dart';
import 'package:flutter_sparring/core/utils/date_formatter.dart';
import 'package:flutter_sparring/features/transaction/domain/entities/transaction_entity.dart';

class BookingCard extends StatelessWidget {
  final TransactionEntity transaction;

  const BookingCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final activity = transaction.transactionItem?.sportActivity;
    final title = activity?.title ?? "Unknown activity";
    final orderDate = transaction.orderDate;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Status: ${transaction.status ?? '-'}"),
            if (orderDate != null) ...[
              const SizedBox(height: 2),
              Text(
                "Order Date: ${DateFormatter.short(orderDate)}",
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ],
        ),
        trailing: Text(
          CurrencyFormatter.format(transaction.totalAmount ?? 0),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
