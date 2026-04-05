import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../domain/entities/monthly_trend.dart';

class MonthlyTrendsChart extends StatelessWidget {
  final List<MonthlyTrend> trends;

  const MonthlyTrendsChart({
    super.key,
    required this.trends,
  });

  @override
  Widget build(BuildContext context) {
    if (trends.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final sortedTrends = List<MonthlyTrend>.from(trends)..sort((a, b) => a.month.compareTo(b.month));
    final maxValue = sortedTrends.map((t) => t.totalSpending).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue > 0 ? maxValue / 4 : 1,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedTrends.length) {
                    final month = sortedTrends[index].month;
                    final monthName = month.split('-')[1];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _getMonthName(int.parse(monthName)),
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const Text('');
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
          minX: 0,
          maxX: (sortedTrends.length - 1).toDouble(),
          minY: 0,
          maxY: maxValue * 1.2,
          lineBarsData: [
            LineChartBarData(
              spots: sortedTrends.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value.totalSpending);
              }).toList(),
              isCurved: true,
              color: const Color(0xFF6B4EFF),
              barWidth: 3,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: const Color(0xFF6B4EFF),
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF6B4EFF).withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}