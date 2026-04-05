import '../../domain/entities/top_category.dart';

class TopCategoryModel extends TopCategory {
  const TopCategoryModel({
    required super.category,
    required super.totalAmount,
    required super.percentage,
  });

  factory TopCategoryModel.fromList(List<Map<String, dynamic>> categories) {
    if (categories.isEmpty) {
      return const TopCategoryModel(
        category: '',
        totalAmount: 0,
        percentage: 0,
      );
    }

    final sortedCategories = List<Map<String, dynamic>>.from(categories)
      ..sort((a, b) {
        final aAmount = (a['total_amount'] as num).toDouble();
        final bAmount = (b['total_amount'] as num).toDouble();
        if (aAmount == bAmount) {
          final aCategory = a['category'] as String;
          final bCategory = b['category'] as String;
          return aCategory.compareTo(bCategory);
        }
        return bAmount.compareTo(aAmount);
      });

    final top = sortedCategories.first;
    final totalAmount = (top['total_amount'] as num).toDouble();
    final totalAll = categories.fold<double>(
      0,
      (sum, cat) => sum + (cat['total_amount'] as num).toDouble(),
    );

    return TopCategoryModel(
      category: top['category'] as String,
      totalAmount: totalAmount,
      percentage: totalAll > 0 ? (totalAmount / totalAll) * 100 : 0,
    );
  }
}