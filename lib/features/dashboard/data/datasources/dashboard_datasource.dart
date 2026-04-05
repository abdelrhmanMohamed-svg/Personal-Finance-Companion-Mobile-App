import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardDataSource {
  final SupabaseClient _supabaseClient;

  DashboardDataSource(this._supabaseClient);

  Future<List<Map<String, dynamic>>> getTransactionsForUser(
    String userId,
    DateTime periodStart,
    DateTime periodEnd,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select()
        .eq('user_id', userId)
        .gte('date', periodStart.toIso8601String())
        .lte('date', periodEnd.toIso8601String());

    return List<Map<String, dynamic>>.from(response);
  }

  Future<double> calculateTotalIncome(
    String userId,
    DateTime periodStart,
    DateTime periodEnd,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select('amount')
        .eq('user_id', userId)
        .eq('type', 'income')
        .gte('date', periodStart.toIso8601String())
        .lte('date', periodEnd.toIso8601String());

    final transactions = List<Map<String, dynamic>>.from(response);
    return transactions.fold<double>(
        0.0, (double sum, t) => sum + (t['amount'] as num).toDouble());
  }

  Future<double> calculateTotalExpenses(
    String userId,
    DateTime periodStart,
    DateTime periodEnd,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select('amount')
        .eq('user_id', userId)
        .eq('type', 'expense')
        .gte('date', periodStart.toIso8601String())
        .lte('date', periodEnd.toIso8601String());

    final transactions = List<Map<String, dynamic>>.from(response);
    double total = 0.0;
    for (final t in transactions) {
      total += (t['amount'] as num).toDouble();
    }
    return total;
  }
}
