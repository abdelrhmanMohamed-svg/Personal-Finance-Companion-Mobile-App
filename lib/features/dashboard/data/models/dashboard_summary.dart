import '../../domain/entities/dashboard_entity.dart';

class DashboardSummary {
  final double currentBalance;
  final double totalIncome;
  final double totalExpenses;
  final DateTime periodStart;
  final DateTime periodEnd;

  const DashboardSummary({
    required this.currentBalance,
    required this.totalIncome,
    required this.totalExpenses,
    required this.periodStart,
    required this.periodEnd,
  });

  DashboardEntity toEntity() {
    return DashboardEntity(
      currentBalance: currentBalance,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      periodStart: periodStart,
      periodEnd: periodEnd,
    );
  }

  factory DashboardSummary.fromEntity(DashboardEntity entity) {
    return DashboardSummary(
      currentBalance: entity.currentBalance,
      totalIncome: entity.totalIncome,
      totalExpenses: entity.totalExpenses,
      periodStart: entity.periodStart,
      periodEnd: entity.periodEnd,
    );
  }
}
