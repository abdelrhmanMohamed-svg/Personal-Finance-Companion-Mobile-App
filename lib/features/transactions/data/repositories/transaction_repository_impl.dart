import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final SupabaseClient _supabaseClient;

  TransactionRepositoryImpl(this._supabaseClient);

  @override
  Future<List<Transaction>> getTransactions(String userId) async {
    final response = await _supabaseClient
        .from('transactions')
        .select()
        .eq('user_id', userId)
        .order('date', ascending: false);

    return response
        .map((map) => TransactionModel.fromMap(map).toEntity())
        .toList();
  }

  @override
  Future<Transaction?> getTransactionById(String id, String userId) async {
    final response = await _supabaseClient
        .from('transactions')
        .select()
        .eq('id', id)
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return TransactionModel.fromMap(response).toEntity();
  }

  @override
  Future<Transaction> addTransaction(Transaction transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    final response = await _supabaseClient
        .from('transactions')
        .insert(model.toMap()..remove('id'))
        .select()
        .single();

    return TransactionModel.fromMap(response).toEntity();
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    final response = await _supabaseClient
        .from('transactions')
        .update(model.toMap()..remove('id'))
        .eq('id', transaction.id)
        .eq('user_id', transaction.userId)
        .select()
        .single();

    return TransactionModel.fromMap(response).toEntity();
  }

  @override
  Future<void> deleteTransaction(String id, String userId) async {
    await _supabaseClient
        .from('transactions')
        .delete()
        .eq('id', id)
        .eq('user_id', userId);
  }

  @override
  Future<List<Transaction>> filterTransactions({
    required String userId,
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
  }) async {
    var query =
        _supabaseClient.from('transactions').select().eq('user_id', userId);

    if (type != null) {
      final typeStr = type == TransactionType.income ? 'income' : 'expense';
      query = query.eq('type', typeStr);
    }

    if (startDate != null) {
      query = query.gte('date', startDate.toIso8601String());
    }

    if (endDate != null) {
      query = query.lte('date', endDate.toIso8601String());
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query =
          query.or('category.ilike.%$searchQuery%,note.ilike.%$searchQuery%');
    }

    final response = await query.order('date', ascending: false);
    return response
        .map((map) => TransactionModel.fromMap(map).toEntity())
        .toList();
  }
}
