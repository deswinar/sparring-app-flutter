import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/shared/widgets/app_loader.dart';
import '../blocs/bookings_cubit.dart';
import 'booking_card.dart';

class BookingsList extends StatelessWidget {
  final ScrollController scrollController;

  const BookingsList({super.key, required this.scrollController});

  Future<void> _onRefresh(BuildContext context) async {
    // Reload data from the start
    await context.read<BookingsCubit>().loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          displacement: 30,
          edgeOffset: 10,
          child: _buildList(context, state),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, BookingsState state) {
    switch (state.status) {
      case BookingsStatus.loading:
        return const Center(child: AppLoader());
      case BookingsStatus.failure:
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 120),
            Center(child: Text(state.errorMessage ?? "Failed to load bookings")),
          ],
        );
      default:
        if (state.transactions.isEmpty) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              SizedBox(height: 120),
              Center(child: Text("No bookings found")),
            ],
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.transactions.length + 1,
          itemBuilder: (context, index) {
            if (index == state.transactions.length) {
              if (state.hasReachedEnd) return const SizedBox(height: 80);
              if (state.status == BookingsStatus.loadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(child: AppLoader()),
                );
              }
              return const SizedBox.shrink();
            }
            return BookingCard(transaction: state.transactions[index]);
          },
        );
    }
  }
}
