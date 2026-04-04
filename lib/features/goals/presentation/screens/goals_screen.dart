import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: AppText(
          text: 'Savings Goals',
          variant: AppTextVariant.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalSavings(),
            SizedBox(height: 24.h),
            _buildGoalsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTotalSavings() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.secondaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.savings_rounded,
                  color: AppColors.onSecondary, size: 24.w),
              SizedBox(width: 8.w),
              AppText(
                text: 'Total Savings',
                variant: AppTextVariant.label,
                color: AppColors.onSecondary.withValues(alpha: 0.7),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          AppText(
            text: '\$3,000.00',
            variant: AppTextVariant.headline,
            color: AppColors.onSecondary,
            fontSize: 32.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Your Goals',
          variant: AppTextVariant.title,
        ),
        SizedBox(height: 16.h),
        _buildGoalCard(
          title: 'Vacation in Bali',
          targetAmount: '\$4,000',
          savedAmount: '\$3,000',
          progress: 0.75,
          icon: Icons.beach_access_rounded,
        ),
        _buildGoalCard(
          title: 'New Car',
          targetAmount: '\$25,000',
          savedAmount: '\$8,500',
          progress: 0.34,
          icon: Icons.directions_car_rounded,
        ),
        _buildGoalCard(
          title: 'Emergency Fund',
          targetAmount: '\$10,000',
          savedAmount: '\$2,000',
          progress: 0.2,
          icon: Icons.health_and_safety_rounded,
        ),
      ],
    );
  }

  Widget _buildGoalCard({
    required String title,
    required String targetAmount,
    required String savedAmount,
    required double progress,
    required IconData icon,
  }) {
    return AppCard(
      padding: EdgeInsets.all(20.w),
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
                child: Icon(icon, color: AppColors.primary, size: 24.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: title,
                      variant: AppTextVariant.body,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      text: 'Target: $targetAmount',
                      variant: AppTextVariant.caption,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12.h,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1.0 ? AppColors.income : AppColors.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: '$savedAmount saved',
                variant: AppTextVariant.caption,
                color: AppColors.textSecondary,
              ),
              AppText(
                text: '${(progress * 100).toInt()}%',
                variant: AppTextVariant.caption,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.85),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        child: BottomNavigationBar(
          currentIndex: 2,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.push('/transactions');
                break;
              case 2:
                break;
              case 3:
                context.push('/insights');
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_rounded),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.flag_rounded),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.insights_rounded),
              label: 'Insights',
            ),
          ],
        ),
      ),
    );
  }
}
