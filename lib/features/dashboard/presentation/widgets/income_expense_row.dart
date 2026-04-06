import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';

class IncomeExpenseRow extends StatelessWidget {
  final double totalIncome;
  final double totalExpenses;

  const IncomeExpenseRow({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final surfaceContainerLowest = brightness == Brightness.dark ? AppColorsDark.surfaceContainerLowest : AppColors.surfaceContainerLowest;
    final onSurface = brightness == Brightness.dark ? AppColorsDark.onSurface : AppColors.onSurface;
    final onSurfaceVariant = brightness == Brightness.dark ? AppColorsDark.onSurfaceVariant : AppColors.onSurfaceVariant;
    final income = brightness == Brightness.dark ? AppColorsDark.income : AppColors.income;
    final incomeBg = brightness == Brightness.dark ? AppColorsDark.incomeBg : AppColors.incomeBg;
    final expense = brightness == Brightness.dark ? AppColorsDark.expense : AppColors.expense;

    final currencyFormatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );

    return Row(
      children: [
        Expanded(
          child: _buildCard(
            context,
            'Income',
            totalIncome,
            currencyFormatter,
            income,
            incomeBg,
            Icons.arrow_downward,
            surfaceContainerLowest,
            onSurface,
            onSurfaceVariant,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildCard(
            context,
            'Expenses',
            totalExpenses,
            currencyFormatter,
            expense,
            expense,
            Icons.arrow_upward,
            surfaceContainerLowest,
            onSurface,
            onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    double amount,
    NumberFormat formatter,
    Color iconColor,
    Color bgColor,
    IconData icon,
    Color surfaceContainerLowest,
    Color onSurface,
    Color onSurfaceVariant,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: bgColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 20.w),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            formatter.format(amount),
            style: TextStyle(
              color: onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              color: onSurfaceVariant,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
