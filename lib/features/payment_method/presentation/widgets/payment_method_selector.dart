import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:flutter_sparring/features/payment_method/presentation/blocs/payment_method_cubit.dart';

class PaymentMethodSelector extends StatelessWidget {
  final Function(PaymentMethodEntity)? onSelected;

  const PaymentMethodSelector({
    super.key,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
      builder: (context, state) {
        if (state is PaymentMethodLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaymentMethodError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is PaymentMethodLoaded) {
          final selected = state.selected;
          final methods = state.methods;

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: methods.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final method = methods[index];
              final isSelected = selected?.id == method.id;

              return GestureDetector(
                onTap: () {
                  context.read<PaymentMethodCubit>().selectPaymentMethod(method);
                  if (onSelected != null) onSelected!(method);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected
                        ? Colors.blueAccent.withValues(alpha: 0.05)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      if (method.imageUrl != null)
                        Image.network(
                          method.imageUrl!,
                          height: 40,
                          width: 40,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method.name ?? "Unknown Bank",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (method.virtualAccountNumber != null)
                              Text(
                                method.virtualAccountNumber!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          // Initial state
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<PaymentMethodCubit>().loadPaymentMethods();
              },
              child: const Text("Load Payment Methods"),
            ),
          );
        }
      },
    );
  }
}
