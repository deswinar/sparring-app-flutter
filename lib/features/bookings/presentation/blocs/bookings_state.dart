part of 'bookings_cubit.dart';

enum BookingsStatus { initial, loading, success, failure, loadingMore }

class BookingsState extends Equatable {
  final List<TransactionEntity> transactions;
  final BookingsStatus status;
  final String? errorMessage;
  final bool hasReachedEnd;
  final int currentPage;
  final String searchQuery;

  const BookingsState({
    this.transactions = const [],
    this.status = BookingsStatus.initial,
    this.errorMessage,
    this.hasReachedEnd = false,
    this.currentPage = 1,
    this.searchQuery = '',
  });

  BookingsState copyWith({
    List<TransactionEntity>? transactions,
    BookingsStatus? status,
    String? errorMessage,
    bool? hasReachedEnd,
    int? currentPage,
    String? searchQuery,
  }) {
    return BookingsState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [transactions, status, errorMessage, hasReachedEnd, currentPage, searchQuery];
}
