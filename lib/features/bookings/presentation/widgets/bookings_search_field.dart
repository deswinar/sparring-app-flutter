import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bookings_cubit.dart';

class BookingsSearchField extends StatelessWidget {
  final TextEditingController controller;

  const BookingsSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        onChanged: context.read<BookingsCubit>().onSearchChanged,
        decoration: InputDecoration(
          hintText: "Search bookings...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
