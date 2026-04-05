import 'package:equatable/equatable.dart';

class MonthlyTrend extends Equatable {
  final String month;
  final double totalSpending;
  final int transactionCount;

  const MonthlyTrend({
    required this.month,
    required this.totalSpending,
    required this.transactionCount,
  });

  @override
  List<Object?> get props => [month, totalSpending, transactionCount];

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'total_spending': totalSpending,
      'transaction_count': transactionCount,
    };
  }
}
