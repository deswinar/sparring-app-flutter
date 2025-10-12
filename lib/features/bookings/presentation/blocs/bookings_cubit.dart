import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter_sparring/features/transaction/domain/usecases/get_my_transactions_usecase.dart';
import 'package:injectable/injectable.dart';

part 'bookings_state.dart';

@injectable
class BookingsCubit extends Cubit<BookingsState> {
  final GetMyTransactionsUseCase _getMyTransactionsUseCase;

  BookingsCubit(this._getMyTransactionsUseCase) : super(const BookingsState());

  Timer? _debounce;

  Future<void> loadInitial({String? search}) async {
    emit(state.copyWith(
      status: BookingsStatus.loading,
      transactions: [],
      currentPage: 1,
      hasReachedEnd: false,
      searchQuery: search ?? '',
    ));
    await _fetchTransactions(page: 1, search: search);
  }

  Future<void> loadMore() async {
    if (state.hasReachedEnd || state.status == BookingsStatus.loadingMore) return;
    emit(state.copyWith(status: BookingsStatus.loadingMore));
    await _fetchTransactions(page: state.currentPage + 1, search: state.searchQuery);
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      loadInitial(search: query.isEmpty ? null : query);
    });
  }

  Future<void> _fetchTransactions({required int page, String? search}) async {
    final result = await _getMyTransactionsUseCase(
      GetMyTransactionsParams(page: page, perPage: 10, search: search),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: BookingsStatus.failure,
        errorMessage: failure.message,
      )),
      (transactions) {
        final allTransactions = [
          if (page > 1) ...state.transactions,
          ...transactions,
        ];

        emit(state.copyWith(
          status: BookingsStatus.success,
          transactions: allTransactions,
          currentPage: page,
          hasReachedEnd: transactions.isEmpty,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
