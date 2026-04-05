import 'package:flutter/material.dart';

import '../../domain/entities/weekly_comparison.dart';

class TrendIndicator extends StatelessWidget {
  final WeeklyComparison comparison;

  const TrendIndicator({
    super.key,
    required this.comparison,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = comparison.trendDirection == TrendDirection.down;
    final isNegative = comparison.trendDirection == TrendDirection.up;

    Color color;
    IconData icon;

    if (isPositive) {
      color = Colors.green;
      icon = Icons.trending_down;
    } else if (isNegative) {
      color = Colors.red;
      icon = Icons.trending_up;
    } else {
      color = Colors.grey;
      icon = Icons.trending_flat;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          '${comparison.percentageChange.abs().toStringAsFixed(1)}%',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}