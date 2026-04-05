import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_datasource.dart';
import '../models/dashboard_summary.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/data/models/transaction_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource _dataSource;
  final SupabaseClient _supabaseClient;

  DashboardRepositoryImpl(this._dataSource, this._supabaseClient);

  @override
  Future<DashboardSummary> getDashboardSummary(String userId) async {
    final now = DateTime.now();
    final periodStart = DateTime(now.year, now.month, 1);
    final periodEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final totalIncome = await _dataSource.calculateTotalIncome(
      userId,
      periodStart,
      periodEnd,
    );

    final totalExpenses = await _dataSource.calculateTotalExpenses(
      userId,
      periodStart,
      periodEnd,
    );

    final currentBalance = totalIncome - totalExpenses;

    return DashboardSummary(
      currentBalance: currentBalance,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      periodStart: periodStart,
      periodEnd: periodEnd,
    );
  }

  @override
  Future<List<Transaction>> getRecentTransactions(String userId,
      {int limit = 5}) async {
    final response = await _supabaseClient
        .from('transactions')
        .select()
        .eq('user_id', userId)
        .order('date', ascending: false)
        .order('created_at', ascending: false)
        .limit(limit);

    return response
        .map((map) => TransactionModel.fromMap(map).toEntity())
        .toList();
  }
}
