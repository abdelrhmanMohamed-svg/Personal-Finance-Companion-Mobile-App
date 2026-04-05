import '../../domain/entities/weekly_comparison.dart';

class WeeklyComparisonModel extends WeeklyComparison {
  const WeeklyComparisonModel({
    required super.currentWeekTotal,
    required super.previousWeekTotal,
    required super.percentageChange,
    required super.trendDirection,
  });

  factory WeeklyComparisonModel.fromMaps({
    required Map<String, dynamic> currentWeek,
    required Map<String, dynamic> previousWeek,
  }) {
    final currentTotal = currentWeek['total'] != null
        ? (currentWeek['total'] as num).toDouble()
        : 0.0;
    final previousTotal = previousWeek['total'] != null
        ? (previousWeek['total'] as num).toDouble()
        : 0.0;

    double percentageChange = 0.0;
    TrendDirection direction = TrendDirection.same;

    if (previousTotal > 0) {
      percentageChange = ((currentTotal - previousTotal) / previousTotal) * 100;
      if (currentTotal > previousTotal) {
        direction = TrendDirection.up;
      } else if (currentTotal < previousTotal) {
        direction = TrendDirection.down;
      }
    } else if (currentTotal > 0) {
      percentageChange = 100.0;
      direction = TrendDirection.up;
    }

    return WeeklyComparisonModel(
      currentWeekTotal: currentTotal,
      previousWeekTotal: previousTotal,
      percentageChange: percentageChange,
      trendDirection: direction,
    );
  }
}