import '../../domain/entities/spending_by_category.dart';
import '../../domain/entities/weekly_comparison.dart';
import '../../domain/entities/monthly_trend.dart';
import '../../domain/entities/top_category.dart';
import '../../domain/repositories/insights_repository.dart';
import '../datasources/insights_datasource.dart';
import '../models/spending_by_category_model.dart';
import '../models/weekly_comparison_model.dart';
import '../models/monthly_trend_model.dart';
import '../models/top_category_model.dart';

class InsightsRepositoryImpl implements InsightsRepository {
  final InsightsDataSource _dataSource;

  InsightsRepositoryImpl(this._dataSource);

  @override
  Future<List<SpendingByCategory>> getSpendingByCategory(String userId) async {
    final response = await _dataSource.getExpensesByCategory(userId);

    final Map<String, Map<String, dynamic>> categoryData = {};

    for (final row in response) {
      final category = row['category'] as String;
      final amount = (row['amount'] as num).abs().toDouble();

      if (categoryData.containsKey(category)) {
        categoryData[category]!['total_amount'] =
            (categoryData[category]!['total_amount'] as double) + amount;
        categoryData[category]!['transaction_count'] =
            (categoryData[category]!['transaction_count'] as int) + 1;
      } else {
        categoryData[category] = {
          'category': category,
          'total_amount': amount,
          'transaction_count': 1,
        };
      }
    }

    final totalSpending = categoryData.values.fold<double>(
      0,
      (sum, cat) => sum + (cat['total_amount'] as double),
    );

    final categories = categoryData.values.map((cat) {
      final totalAmount = cat['total_amount'] as double;
      final map = {
        'category': cat['category'],
        'total_amount': totalAmount,
        'percentage':
            totalSpending > 0 ? (totalAmount / totalSpending) * 100 : 0.0,
        'transaction_count': cat['transaction_count'],
      };
      return SpendingByCategoryModel.fromMap(map);
    }).toList();

    categories.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));

    return categories;
  }

  @override
  Future<WeeklyComparison> getWeeklyComparison(String userId) async {
    final now = DateTime.now();
    final startOfCurrentWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfPreviousWeek =
        startOfCurrentWeek.subtract(const Duration(days: 7));

    final currentWeekResponse = await _dataSource.getCurrentWeekExpenses(
      userId,
      startOfCurrentWeek,
    );

    final previousWeekResponse = await _dataSource.getPreviousWeekExpenses(
      userId,
      startOfPreviousWeek,
      startOfCurrentWeek,
    );

    double currentTotal = 0;
    for (final row in currentWeekResponse) {
      currentTotal += (row['amount'] as num).abs().toDouble();
    }

    double previousTotal = 0;
    for (final row in previousWeekResponse) {
      previousTotal += (row['amount'] as num).abs().toDouble();
    }

    final currentWeekMap = {'total': currentTotal};
    final previousWeekMap = {'total': previousTotal};

    return WeeklyComparisonModel.fromMaps(
      currentWeek: currentWeekMap,
      previousWeek: previousWeekMap,
    );
  }

  @override
  Future<List<MonthlyTrend>> getMonthlyTrends(String userId) async {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);

    final response = await _dataSource.getMonthlyExpenses(userId, startOfYear);

    final Map<String, Map<String, dynamic>> monthData = {};

    for (final row in response) {
      final date = DateTime.parse(row['date'] as String);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      final amount = (row['amount'] as num).abs().toDouble();

      if (monthData.containsKey(monthKey)) {
        monthData[monthKey]!['total_spending'] =
            (monthData[monthKey]!['total_spending'] as double) + amount;
        monthData[monthKey]!['transaction_count'] =
            (monthData[monthKey]!['transaction_count'] as int) + 1;
      } else {
        monthData[monthKey] = {
          'month': monthKey,
          'total_spending': amount,
          'transaction_count': 1,
        };
      }
    }

    final trends = monthData.values.map((data) {
      return MonthlyTrendModel.fromMap(data);
    }).toList();

    trends.sort((a, b) => b.month.compareTo(a.month));

    return trends;
  }

  @override
  Future<TopCategory> getTopCategory(String userId) async {
    final categories = await getSpendingByCategory(userId);

    if (categories.isEmpty) {
      return const TopCategory(
        category: '',
        totalAmount: 0,
        percentage: 0,
      );
    }

    final categoryMaps = categories.map((c) => c.toMap()).toList();

    return TopCategoryModel.fromList(categoryMaps);
  }
}
