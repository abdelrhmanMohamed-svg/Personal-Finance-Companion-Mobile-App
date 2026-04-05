import 'package:equatable/equatable.dart';

enum TrendDirection { up, down, same }

class WeeklyComparison extends Equatable {
  final double currentWeekTotal;
  final double previousWeekTotal;
  final double percentageChange;
  final TrendDirection trendDirection;

  const WeeklyComparison({
    required this.currentWeekTotal,
    required this.previousWeekTotal,
    required this.percentageChange,
    required this.trendDirection,
  });

  @override
  List<Object?> get props => [
        currentWeekTotal,
        previousWeekTotal,
        percentageChange,
        trendDirection,
      ];
}
