import '../../domain/entities/dashboard_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

class GetDashboardSummary {
  final DashboardRepository _repository;

  GetDashboardSummary(this._repository);

  Future<DashboardEntity> call(String userId) async {
    final summary = await _repository.getDashboardSummary(userId);
    return summary.toEntity();
  }
}
