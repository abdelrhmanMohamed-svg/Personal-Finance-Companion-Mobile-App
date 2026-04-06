import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactions;
  final TransactionFilter? activeFilter;

  const TransactionsLoaded({
    required this.transactions,
    this.activeFilter,
  });

  @override
  List<Object?> get props => [transactions, activeFilter];
}

class TransactionFormState extends TransactionsState {
  final TransactionType type;
  final String category;
  final DateTime date;
  final String? amount;
  final String? note;

  const TransactionFormState({
    this.type = TransactionType.expense,
    this.category = 'Food',
    required this.date,
    this.amount,
    this.note,
  });

  factory TransactionFormState.initial() {
    return TransactionFormState(
      type: TransactionType.expense,
      category: 'Food',
      date: DateTime.now(),
    );
  }

  TransactionFormState copyWith({
    TransactionType? type,
    String? category,
    DateTime? date,
    String? amount,
    String? note,
    bool clearAmount = false,
    bool clearNote = false,
  }) {
    return TransactionFormState(
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
      amount: clearAmount ? null : (amount ?? this.amount),
      note: clearNote ? null : (note ?? this.note),
    );
  }

  @override
  List<Object?> get props => [type, category, date, amount, note];
}

class TransactionAdded extends TransactionsState {
  final Transaction transaction;

  const TransactionAdded(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionUpdated extends TransactionsState {
  final Transaction transaction;

  const TransactionUpdated(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionDeleted extends TransactionsState {
  final String transactionId;

  const TransactionDeleted(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}

class TransactionsError extends TransactionsState {
  final String message;

  const TransactionsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TransactionFilter extends Equatable {
  final TransactionType? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? searchQuery;

  const TransactionFilter({
    this.type,
    this.startDate,
    this.endDate,
    this.searchQuery,
  });

  TransactionFilter copyWith({
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    bool clearType = false,
    bool clearStartDate = false,
    bool clearEndDate = false,
    bool clearSearchQuery = false,
  }) {
    return TransactionFilter(
      type: clearType ? null : (type ?? this.type),
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
    );
  }

  bool get isEmpty =>
      type == null &&
      startDate == null &&
      endDate == null &&
      (searchQuery == null || searchQuery!.isEmpty);

  @override
  List<Object?> get props => [type, startDate, endDate, searchQuery];
}
