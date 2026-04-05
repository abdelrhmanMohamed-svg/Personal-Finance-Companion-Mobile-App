import '../../domain/repositories/dashboard_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';

class GetRecentTransactions {
  final DashboardRepository _repository;

  GetRecentTransactions(this._repository);

  Future<List<Transaction>> call(String userId, {int limit = 5}) async {
    return _repository.getRecentTransactions(userId, limit: limit);
  }
}
