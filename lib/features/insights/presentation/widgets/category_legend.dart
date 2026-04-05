import 'package:flutter/material.dart';

import '../../domain/entities/spending_by_category.dart';

class CategoryLegend extends StatelessWidget {
  final List<SpendingByCategory> categories;

  const CategoryLegend({
    super.key,
    required this.categories,
  });

  static const List<Color> chartColors = [
    Color(0xFF6B4EFF),
    Color(0xFFFF6B6B),
    Color(0xFF4ECDC4),
    Color(0xFFFFE66D),
    Color(0xFF95E1D3),
    Color(0xFFF38181),
    Color(0xFFAA96DA),
    Color(0xFFFCBF49),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: chartColors[index % chartColors.length],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.category,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Text(
                '\$${category.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '${category.percentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}