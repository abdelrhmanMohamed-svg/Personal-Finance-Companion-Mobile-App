import '../../domain/entities/spending_by_category.dart';

class SpendingByCategoryModel extends SpendingByCategory {
  const SpendingByCategoryModel({
    required String category,
    required double totalAmount,
    required double percentage,
    required int transactionCount,
  }) : super(
          category: category,
          totalAmount: totalAmount,
          percentage: percentage,
          transactionCount: transactionCount,
        );

  factory SpendingByCategoryModel.fromMap(Map<String, dynamic> map) {
    return SpendingByCategoryModel(
      category: map['category'] as String,
      totalAmount: (map['total_amount'] as num).toDouble(),
      percentage: (map['percentage'] as num).toDouble(),
      transactionCount: map['transaction_count'] as int,
    );
  }
}
