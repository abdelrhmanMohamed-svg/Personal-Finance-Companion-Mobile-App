import 'package:supabase_flutter/supabase_flutter.dart';

class GoalsDataSource {
  final SupabaseClient _supabaseClient;

  GoalsDataSource(this._supabaseClient);

  Future<List<Map<String, dynamic>>> getBudgets(String userId) async {
    final response = await _supabaseClient
        .from('budgets')
        .select()
        .eq('user_id', userId)
        .eq('is_deleted', false)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getBudgetById(String id, String userId) async {
    final response = await _supabaseClient
        .from('budgets')
        .select()
        .eq('id', id)
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>?> getCurrentBudget(String userId) async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final response = await _supabaseClient
        .from('budgets')
        .select()
        .eq('user_id', userId)
        .eq('is_deleted', false)
        .gte('period_start', startOfMonth.toIso8601String())
        .lte('period_end', endOfMonth.toIso8601String());

    final List<dynamic> results = response as List<dynamic>;

    for (final item in results) {
      final map = Map<String, dynamic>.from(item);
      if (map['category'] == null) {
        return map;
      }
    }

    return null;
  }

  Future<Map<String, dynamic>> createBudget(Map<String, dynamic> data) async {
    final response =
        await _supabaseClient.from('budgets').insert(data).select().single();

    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> updateBudget(
    String id,
    String userId,
    Map<String, dynamic> data,
  ) async {
    final response = await _supabaseClient
        .from('budgets')
        .update(data)
        .eq('id', id)
        .eq('user_id', userId)
        .select()
        .single();

    return Map<String, dynamic>.from(response);
  }

  Future<void> deleteBudget(String id, String userId) async {
    await _supabaseClient
        .from('budgets')
        .update({'is_deleted': true})
        .eq('id', id)
        .eq('user_id', userId);
  }

  Future<List<Map<String, dynamic>>> getSavingsGoals(String userId) async {
    final response = await _supabaseClient
        .from('savings_goals')
        .select()
        .eq('user_id', userId)
        .eq('is_deleted', false)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getSavingsGoalById(
      String id, String userId) async {
    final response = await _supabaseClient
        .from('savings_goals')
        .select()
        .eq('id', id)
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> createSavingsGoal(
      Map<String, dynamic> data) async {
    final response = await _supabaseClient
        .from('savings_goals')
        .insert(data)
        .select()
        .single();

    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> updateSavingsGoal(
    String id,
    String userId,
    Map<String, dynamic> data,
  ) async {
    final response = await _supabaseClient
        .from('savings_goals')
        .update(data)
        .eq('id', id)
        .eq('user_id', userId)
        .select()
        .single();

    return Map<String, dynamic>.from(response);
  }

  Future<void> deleteSavingsGoal(String id, String userId) async {
    await _supabaseClient
        .from('savings_goals')
        .update({'is_deleted': true})
        .eq('id', id)
        .eq('user_id', userId);
  }

  Future<Map<String, dynamic>?> getStreak(String userId) async {
    final response = await _supabaseClient
        .from('streaks')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return Map<String, dynamic>.from(response);
  }

  Future<Map<String, dynamic>> createOrUpdateStreak(
      Map<String, dynamic> data) async {
    final existing = await getStreak(data['user_id'] as String);

    if (existing == null) {
      final response =
          await _supabaseClient.from('streaks').insert(data).select().single();

      return Map<String, dynamic>.from(response);
    } else {
      final response = await _supabaseClient
          .from('streaks')
          .update(data)
          .eq('user_id', data['user_id'] as String)
          .select()
          .single();

      return Map<String, dynamic>.from(response);
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionsForPeriod(
    String userId,
    String type,
    DateTime start,
    DateTime end, {
    String? category,
  }) async {
    var query = _supabaseClient
        .from('transactions')
        .select('amount')
        .eq('user_id', userId)
        .eq('type', type)
        .gte('date', start.toIso8601String())
        .lte('date', end.toIso8601String());

    if (category != null) {
      query = query.eq('category', category);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getIncomeTransactionsSince(
    String userId,
    DateTime since,
  ) async {
    final response = await _supabaseClient
        .from('transactions')
        .select('amount')
        .eq('user_id', userId)
        .eq('type', 'income')
        .gte('date', since.toIso8601String());

    return List<Map<String, dynamic>>.from(response);
  }
}
