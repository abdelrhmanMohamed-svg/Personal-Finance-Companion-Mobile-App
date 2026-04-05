import '../../domain/entities/monthly_trend.dart';

class MonthlyTrendModel extends MonthlyTrend {
  const MonthlyTrendModel({
    required super.month,
    required super.totalSpending,
    required super.transactionCount,
  });

  factory MonthlyTrendModel.fromMap(Map<String, dynamic> map) {
    return MonthlyTrendModel(
      month: map['month'] as String,
      totalSpending: (map['total_spending'] as num).toDouble(),
      transactionCount: map['transaction_count'] as int,
    );
  }
}