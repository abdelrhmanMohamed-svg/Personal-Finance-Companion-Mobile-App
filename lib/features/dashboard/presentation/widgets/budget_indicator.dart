import 'package:flutter/material.dart';

class BudgetIndicator extends StatelessWidget {
  final bool isUnderBudget;
  final double? budgetLimit;
  final double? currentSpent;

  const BudgetIndicator({
    super.key,
    required this.isUnderBudget,
    this.budgetLimit,
    this.currentSpent,
  });

  @override
  Widget build(BuildContext context) {
    final color = isUnderBudget ? Colors.green : Colors.red;
    final icon = isUnderBudget ? Icons.check_circle : Icons.warning;
    final text = isUnderBudget ? 'Under Budget' : 'Over Budget';

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