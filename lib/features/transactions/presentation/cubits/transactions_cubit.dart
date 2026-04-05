import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionRepository _repository;
  final SupabaseClient _supabaseClient;

  TransactionsCubit(this._repository, this._supabaseClient)
      : super(const TransactionsInitial());

  String get _userId => _supabaseClient.auth.currentUser?.id ?? '';

  Future<void> loadTransactions() async {
    try {
      emit(const TransactionsLoading());
      final transactions = await _repository.getTransactions(_userId);
      emit(TransactionsLoaded(transactions: transactions));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  Future<void> addTransaction({
    required double amount,
    required TransactionType type,
    required String category,
    required DateTime date,
    String? note,
  }) async {
    try {
      emit(const TransactionsLoading());

      final now = DateTime.now();
      final transaction = Transaction(
        id: '',
        userId: _userId,
        amount: amount,
        type: type,
        category: category,
        date: date,
        note: note,
        createdAt: now,
        updatedAt: now,
      );

      final addedTransaction = await _repository.addTransaction(transaction);
      emit(TransactionAdded(addedTransaction));

      await loadTransactions();
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    try {
      emit(const TransactionsLoading());

      final updatedTransaction = await _repository.updateTransaction(
        transaction.copyWith(updatedAt: DateTime.now()),
      );

      emit(TransactionUpdated(updatedTransaction));
      await loadTransactions();
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      emit(const TransactionsLoading());

      await _repository.deleteTransaction(transactionId, _userId);
      emit(TransactionDeleted(transactionId));

      await loadTransactions();
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  Future<void> filterTransactions(TransactionFilter filter) async {
    try {
      emit(const TransactionsLoading());

      final transactions = await _repository.filterTransactions(
        userId: _userId,
        type: filter.type,
        startDate: filter.startDate,
        endDate: filter.endDate,
        searchQuery: filter.searchQuery,
      );

      emit(TransactionsLoaded(
        transactions: transactions,
        activeFilter: filter.isEmpty ? null : filter,
      ));
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  void clearFilter() {
    loadTransactions();
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  void setTransactionType(TransactionType type) {
    final currentState = state;
    if (currentState is TransactionFormState) {
      emit(currentState.copyWith(type: type));
    } else {
      emit(TransactionFormState.initial().copyWith(type: type));
    }
  }

  void setCategory(String category) {
    final currentState = state;
    if (currentState is TransactionFormState) {
      emit(currentState.copyWith(category: category));
    } else {
      emit(TransactionFormState.initial().copyWith(category: category));
    }
  }

  void setDate(DateTime date) {
    final currentState = state;
    if (currentState is TransactionFormState) {
      emit(currentState.copyWith(date: date));
    } else {
      emit(TransactionFormState.initial().copyWith(date: date));
    }
  }

  void setAmount(String amount) {
    final currentState = state;
    if (currentState is TransactionFormState) {
      emit(currentState.copyWith(amount: amount));
    } else {
      emit(TransactionFormState.initial().copyWith(amount: amount));
    }
  }

  void setNote(String note) {
    final currentState = state;
    if (currentState is TransactionFormState) {
      emit(currentState.copyWith(note: note));
    } else {
      emit(TransactionFormState.initial().copyWith(note: note));
    }
  }

  void resetForm() {
    emit(TransactionFormState.initial());
  }
}
