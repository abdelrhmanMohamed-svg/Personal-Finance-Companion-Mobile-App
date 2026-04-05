import '../entities/spending_by_category.dart';
import '../entities/weekly_comparison.dart';
import '../entities/monthly_trend.dart';
import '../entities/top_category.dart';

abstract class InsightsRepository {
  Future<List<SpendingByCategory>> getSpendingByCategory(String userId);
  Future<WeeklyComparison> getWeeklyComparison(String userId);
  Future<List<MonthlyTrend>> getMonthlyTrends(String userId);
  Future<TopCategory> getTopCategory(String userId);
}
