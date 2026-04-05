import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions(String userId);
  Future<Transaction?> getTransactionById(String id, String userId);
  Future<Transaction> addTransaction(Transaction transaction);
  Future<Transaction> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id, String userId);
  Future<List<Transaction>> filterTransactions({
    required String userId,
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
  });
}
