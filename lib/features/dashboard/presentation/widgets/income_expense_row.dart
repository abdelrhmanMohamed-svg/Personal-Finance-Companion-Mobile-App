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
            AppColors.income,
            AppColors.incomeBg,
            Icons.arrow_downward,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildCard(
            context,
            'Expenses',
            totalExpenses,
            currencyFormatter,
            AppColors.tertiaryLight,
            AppColors.expenseIcon,
            Icons.arrow_upward,
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
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
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
              color: AppColors.onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
