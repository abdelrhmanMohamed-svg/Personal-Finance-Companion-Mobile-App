import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';

class SavingsGoalsWidget extends StatelessWidget {
  final List<GoalData> goals;
  final VoidCallback? onTap;

  const SavingsGoalsWidget({
    super.key,
    required this.goals,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: 'SAVINGS GOALS',
              variant: AppTextVariant.caption,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
            if (onTap != null)
              GestureDetector(
                onTap: onTap,
                child: AppText(
                  text: 'See All',
                  variant: AppTextVariant.label,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (goals.isEmpty)
          _buildEmptyState()
        else
          ...goals.map((goal) => _buildGoalCard(goal)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.flag_rounded,
            color: AppColors.primary.withValues(alpha: 0.5),
            size: 40.w,
          ),
          SizedBox(height: 12.h),
          AppText(
            text: 'No savings goals yet',
            variant: AppTextVariant.body,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 4.h),
          AppText(
            text: 'Set a goal to start saving',
            variant: AppTextVariant.caption,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(GoalData goal) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(goal.icon, color: AppColors.primary, size: 20.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: goal.title,
                      variant: AppTextVariant.body,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 2.h),
                    AppText(
                      text: '\$${goal.savedAmount.toStringAsFixed(0)} of \$${goal.targetAmount.toStringAsFixed(0)}',
                      variant: AppTextVariant.caption,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: goal.progress >= 1.0
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: AppText(
                  text: '${(goal.progress * 100).toInt()}%',
                  variant: AppTextVariant.caption,
                  color: goal.progress >= 1.0 ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: goal.progress.clamp(0.0, 1.0),
              minHeight: 8.h,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: AlwaysStoppedAnimation<Color>(
                goal.progress >= 1.0 ? AppColors.primary : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoalData {
  final String title;
  final double targetAmount;
  final double savedAmount;
  final double progress;
  final IconData icon;

  const GoalData({
    required this.title,
    required this.targetAmount,
    required this.savedAmount,
    required this.progress,
    required this.icon,
  });
}
