import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../domain/entities/weekly_comparison.dart';

class WeeklyComparisonChart extends StatelessWidget {
  final WeeklyComparison comparison;

  const WeeklyComparisonChart({
    super.key,
    required this.comparison,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = comparison.currentWeekTotal > comparison.previousWeekTotal
        ? comparison.currentWeekTotal
        : comparison.previousWeekTotal;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue * 1.2,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final labels = ['This Week', 'Last Week'];
                return BarTooltipItem(
                  '${labels[rodIndex]}\n\$${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final labels = ['This Week', 'Last Week'];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[value.toInt()],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue > 0 ? maxValue / 4 : 1,
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: comparison.currentWeekTotal,
                  color: _getBarColor(comparison.trendDirection),
                  width: 40,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: comparison.previousWeekTotal,
                  color: Colors.grey.shade400,
                  width: 40,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getBarColor(TrendDirection direction) {
    switch (direction) {
      case TrendDirection.down:
        return Colors.green;
      case TrendDirection.up:
        return Colors.red;
      case TrendDirection.same:
        return Colors.blue;
    }
  }
}