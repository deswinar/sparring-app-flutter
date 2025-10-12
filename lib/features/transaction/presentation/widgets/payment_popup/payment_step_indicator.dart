import 'package:flutter/material.dart';

class PaymentStepIndicator extends StatelessWidget {
  final bool isActive;
  final String label;

  const PaymentStepIndicator({
    super.key,
    required this.isActive,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? color.primary : Colors.grey.shade400,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? color.primary : Colors.grey,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
