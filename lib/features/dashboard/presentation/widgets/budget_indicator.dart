import 'package:flutter/material.dart';

enum BudgetStatus {
  safe,
  warning,
  exceeded,
}

class BudgetIndicator extends StatelessWidget {
  final BudgetStatus status;
  final double? budgetLimit;
  final double? currentSpent;

  const BudgetIndicator({
    super.key,
    required this.status,
    this.budgetLimit,
    this.currentSpent,
  });

  factory BudgetIndicator.fromProgress({
    required double currentSpent,
    required double budgetLimit,
  }) {
    final percentage = budgetLimit > 0 ? currentSpent / budgetLimit : 0.0;
    final BudgetStatus status;
    if (percentage >= 1.0) {
      status = BudgetStatus.exceeded;
    } else if (percentage >= 0.8) {
      status = BudgetStatus.warning;
    } else {
      status = BudgetStatus.safe;
    }
    return BudgetIndicator(
      status: status,
      currentSpent: currentSpent,
      budgetLimit: budgetLimit,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    String text;

    switch (status) {
      case BudgetStatus.safe:
        color = Colors.green;
        icon = Icons.check_circle;
        text = 'Under Budget';
        break;
      case BudgetStatus.warning:
        color = Colors.orange;
        icon = Icons.warning_amber;
        text = 'Near Limit (80%)';
        break;
      case BudgetStatus.exceeded:
        color = Colors.red;
        icon = Icons.error;
        text = 'Over Budget';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}