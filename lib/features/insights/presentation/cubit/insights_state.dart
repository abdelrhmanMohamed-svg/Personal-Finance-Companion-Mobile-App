import 'package:equatable/equatable.dart';

import '../../domain/entities/spending_by_category.dart';
import '../../domain/entities/weekly_comparison.dart';
import '../../domain/entities/monthly_trend.dart';
import '../../domain/entities/top_category.dart';

abstract class InsightsState extends Equatable {
  const InsightsState();

  @override
  List<Object?> get props => [];
}

class InsightsInitial extends InsightsState {}

class InsightsLoading extends InsightsState {}

class InsightsLoaded extends InsightsState {
  final List<SpendingByCategory> categoryBreakdown;
  final WeeklyComparison weeklyComparison;
  final List<MonthlyTrend> monthlyTrends;
  final TopCategory topCategory;

  const InsightsLoaded({
    required this.categoryBreakdown,
    required this.weeklyComparison,
    required this.monthlyTrends,
    required this.topCategory,
  });

  @override
  List<Object?> get props =>
      [categoryBreakdown, weeklyComparison, monthlyTrends, topCategory];
}

class InsightsEmpty extends InsightsState {}

class InsightsError extends InsightsState {
  final String message;

  const InsightsError(this.message);

  @override
  List<Object?> get props => [message];
}
