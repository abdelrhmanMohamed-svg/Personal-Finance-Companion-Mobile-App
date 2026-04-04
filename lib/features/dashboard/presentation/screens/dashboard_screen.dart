import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 24.h),
              const BalanceCard(),
              SizedBox(height: 16.h),
              const IncomeExpenseCard(),
              SizedBox(height: 24.h),
              _buildQuickActions(context),
              SizedBox(height: 24.h),
              _buildRecentTransactions(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Good morning',
          variant: AppTextVariant.label,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 4.h),
        AppText(
          text: 'Your Finances',
          variant: AppTextVariant.headline,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'QUICK ACTIONS',
          variant: AppTextVariant.caption,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Add Transaction',
                icon: Icons.add_rounded,
                onPressed: () => context.push('/transactions/add'),
                isFullWidth: true,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppButton(
                text: 'Set Goal',
                icon: Icons.flag_rounded,
                variant: AppButtonVariant.outlined,
                onPressed: () => context.push('/goals'),
                isFullWidth: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: 'Recent Transactions',
              variant: AppTextVariant.title,
            ),
            TextButton(
              onPressed: () => context.push('/transactions'),
              child: AppText(
                text: 'See All',
                variant: AppTextVariant.label,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AppCard(
          padding: EdgeInsets.all(20.w),
          child: Center(
            child: AppText(
              text: 'No recent transactions',
              variant: AppTextVariant.body,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
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
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          elevation: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                break;
              case 1:
                context.push('/transactions');
                break;
              case 2:
                context.push('/goals');
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

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Total Balance',
            variant: AppTextVariant.label,
            color: AppColors.onPrimary.withValues(alpha: 0.7),
          ),
          SizedBox(height: 8.h),
          AppText(
            text: '\$0.00',
            variant: AppTextVariant.headline,
            color: AppColors.onPrimary,
            fontSize: 36.sp,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              _buildTrendIndicator(
                Icons.arrow_upward_rounded,
                '+\$0.00',
                AppColors.onPrimary,
              ),
              SizedBox(width: 24.w),
              _buildTrendIndicator(
                Icons.arrow_downward_rounded,
                '-\$0.00',
                AppColors.onPrimary.withValues(alpha: 0.7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendIndicator(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16.w),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            context,
            'Income',
            '\$0.00',
            Icons.arrow_downward_rounded,
            AppColors.income,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildSummaryCard(
            context,
            'Expenses',
            '\$0.00',
            Icons.arrow_upward_rounded,
            AppColors.expense,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return AppCard(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 20.w),
          ),
          SizedBox(height: 12.h),
          AppText(
            text: title,
            variant: AppTextVariant.caption,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 4.h),
          AppText(
            text: amount,
            variant: AppTextVariant.title,
            color: color,
          ),
        ],
      ),
    );
  }
}
