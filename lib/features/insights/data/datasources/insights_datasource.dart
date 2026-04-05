import 'package:supabase_flutter/supabase_flutter.dart';

class InsightsDataSource {
  final SupabaseClient _supabaseClient;

  InsightsDataSource(this._supabaseClient);

  Future<List<Map<String, dynamic>>> getExpensesByCategory(
    String userId,
  ) async {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);

    final response = await _supabaseClient
        .from('transactions')
        .select()
        .eq('user_id', userId)
        .eq('type', 'expense')
        .gte('date', startOfYear.toIso8601String());

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getCurrentWeekExpenses(
    String userId,
    DateTime startOfCurrentWeek,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select('amount')
        .eq('user_id', userId)
        .eq('type', 'expense')
        .gte('date', startOfCurrentWeek.toIso8601String())
        .lt('date',
            startOfCurrentWeek.add(const Duration(days: 7)).toIso8601String());

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getPreviousWeekExpenses(
    String userId,
    DateTime startOfPreviousWeek,
    DateTime startOfCurrentWeek,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select('amount')
        .eq('user_id', userId)
        .eq('type', 'expense')
        .gte('date', startOfPreviousWeek.toIso8601String())
        .lt('date', startOfCurrentWeek.toIso8601String());

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getMonthlyExpenses(
    String userId,
    DateTime startOfYear,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select('date, amount')
        .eq('user_id', userId)
        .eq('type', 'expense')
        .gte('date', startOfYear.toIso8601String())
        .order('date');

    return List<Map<String, dynamic>>.from(response);
  }
}
