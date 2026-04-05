class DashboardEntity {
  final double currentBalance;
  final double totalIncome;
  final double totalExpenses;
  final DateTime periodStart;
  final DateTime periodEnd;

  const DashboardEntity({
    required this.currentBalance,
    required this.totalIncome,
    required this.totalExpenses,
    required this.periodStart,
    required this.periodEnd,
  });
}
