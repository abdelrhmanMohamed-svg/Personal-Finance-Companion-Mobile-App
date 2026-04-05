import '../../data/models/dashboard_summary.dart';
import '../../../transactions/domain/entities/transaction.dart';

abstract class DashboardRepository {
  Future<DashboardSummary> getDashboardSummary(String userId);
  Future<List<Transaction>> getRecentTransactions(String userId,
      {int limit = 5});
}
