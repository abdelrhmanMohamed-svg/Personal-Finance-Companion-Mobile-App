import 'package:equatable/equatable.dart';

class SpendingByCategory extends Equatable {
  final String category;
  final double totalAmount;
  final double percentage;
  final int transactionCount;

  const SpendingByCategory({
    required this.category,
    required this.totalAmount,
    required this.percentage,
    required this.transactionCount,
  });

  @override
  List<Object?> get props =>
      [category, totalAmount, percentage, transactionCount];

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'total_amount': totalAmount,
      'percentage': percentage,
      'transaction_count': transactionCount,
    };
  }
}
