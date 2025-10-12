import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/di/injection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sparring/features/payment_method/domain/entities/payment_method_entity.dart';
import 'package:flutter_sparring/features/payment_method/presentation/blocs/payment_method_cubit.dart';
import 'package:flutter_sparring/features/payment_method/presentation/widgets/payment_method_selector.dart';
import 'package:flutter_sparring/features/transaction/presentation/widgets/payment_popup/payment_instruction_card.dart';
import 'package:flutter_sparring/features/transaction/presentation/widgets/payment_popup/payment_step_indicator.dart';

class PaymentPopup extends StatefulWidget {
  final void Function(PaymentMethodEntity method, File proof)? onSubmit;
  final int? amount;
  final String? activityTitle;

  const PaymentPopup({
    super.key,
    this.onSubmit,
    this.amount,
    this.activityTitle,
  });

  @override
  State<PaymentPopup> createState() => _PaymentPopupState();
}

class _PaymentPopupState extends State<PaymentPopup> {
  int _step = 1;
  PaymentMethodEntity? _selectedMethod;
  File? _proofFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _proofFile = File(picked.path));
  }

  void _goNext() {
    if (_step == 1 && _selectedMethod != null) {
      setState(() => _step = 2);
    } else if (_step == 2 && _proofFile != null) {
      widget.onSubmit?.call(_selectedMethod!, _proofFile!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Step indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                PaymentStepIndicator(isActive: true, label: "Pilih Metode"),
                SizedBox(width: 16),
                PaymentStepIndicator(isActive: false, label: "Upload Bukti"),
              ],
            ),
            const SizedBox(height: 24),

            if (_step == 1)
              BlocProvider(
                create: (_) =>
                    getIt<PaymentMethodCubit>()..loadPaymentMethods(),
                child: PaymentMethodSelector(
                  onSelected: (method) => setState(() => _selectedMethod = method),
                ),
              )
            else if (_step == 2)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedMethod != null)
                    PaymentInstructionCard(
                      method: _selectedMethod!,
                      amount: widget.amount,
                      activityTitle: widget.activityTitle,
                    ),
                  const SizedBox(height: 12),
                  _buildUploadSection(color),
                ],
              ),

            const SizedBox(height: 24),
            _buildBottomButtons(color),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection(ColorScheme color) {
    return Column(
      children: [
        if (_proofFile != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              _proofFile!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        else
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.upload, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text("Upload bukti pembayaran"),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        if (_proofFile != null)
          TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.edit),
            label: const Text("Ganti Gambar"),
          ),
      ],
    );
  }

  Widget _buildBottomButtons(ColorScheme color) {
    return Row(
      children: [
        if (_step == 2)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _step = 1),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali"),
            ),
          ),
        if (_step == 2) const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: (_step == 1 && _selectedMethod == null)
                ? null
                : (_step == 2 && _proofFile == null)
                    ? null
                    : _goNext,
            child: Text(_step == 1 ? "Lanjut" : "Kirim Bukti Pembayaran"),
          ),
        ),
      ],
    );
  }
}
