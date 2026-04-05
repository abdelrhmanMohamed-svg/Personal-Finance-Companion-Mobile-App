import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_datasource.dart';
import '../models/dashboard_summary.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource _dataSource;

  DashboardRepositoryImpl(this._dataSource);

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
}
