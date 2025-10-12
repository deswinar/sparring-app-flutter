import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sparring/core/utils/currency_formatter.dart';
import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:flutter_sparring/shared/widgets/app_snackbar.dart';

class PaymentInstructionCard extends StatelessWidget {
  final PaymentMethodEntity method;
  final int? amount;
  final String? activityTitle;

  const PaymentInstructionCard({
    super.key,
    required this.method,
    this.amount,
    this.activityTitle,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Card(
      color: color.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Instruksi Pembayaran",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            _buildBankRow(context),
            const SizedBox(height: 8),
            if (amount != null) _buildAmountRow(context),
            if (activityTitle != null) ...[
              const SizedBox(height: 8),
              Text(
                "Kegiatan: $activityTitle",
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBankRow(BuildContext context) {
    final accountText = method.virtualAccountNumber ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "${method.name ?? '-'}${accountText.isNotEmpty ? ' ($accountText)' : ''}",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (accountText.isNotEmpty) {
              await Clipboard.setData(ClipboardData(text: accountText));
              if (context.mounted) {
                AppSnackbar.show(context,
                    message: "Nomor rekening disalin ke clipboard");
              }
            }
          },
          icon: const Icon(Icons.copy_rounded, size: 20),
          tooltip: "Salin nomor rekening",
        ),
      ],
    );
  }

  Widget _buildAmountRow(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total yang harus dibayar:"),
        Row(
          children: [
            Text(
              CurrencyFormatter.format(amount!),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: color.primary,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: CurrencyFormatter.format(amount!)),
                );
                if (context.mounted) {
                  AppSnackbar.show(context,
                      message: "Jumlah pembayaran disalin ke clipboard");
                }
              },
              icon: const Icon(Icons.copy_rounded, size: 20),
              tooltip: "Salin jumlah pembayaran",
            ),
          ],
        ),
      ],
    );
  }
}
