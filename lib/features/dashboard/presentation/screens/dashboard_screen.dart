import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/income_expense_row.dart';
import '../widgets/summary_card.dart';
import '../widgets/savings_goals_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<DashboardCubit>().refreshDashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<DashboardCubit>().refreshDashboard(),

      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DashboardEmpty) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(height: 24.h),
                      const EmptyStateWidget(),
                      SizedBox(height: 24.h),
                      _buildQuickActions(context),
                    ],
                  ),
                );
              }

              if (state is DashboardError) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(height: 24.h),
                      ErrorStateWidget(
                        message: state.message,
                        onRetry: () =>
                            context.read<DashboardCubit>().loadDashboard(),
                      ),
                      SizedBox(height: 24.h),
                      _buildQuickActions(context),
                    ],
                  ),
                );
              }

              if (state is DashboardLoaded) {
                return _buildLoadedContent(context, state.dashboard);
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, DashboardEntity dashboard) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 24.h),
          BalanceCard(balance: dashboard.currentBalance),
          SizedBox(height: 16.h),
          IncomeExpenseRow(
            totalIncome: dashboard.totalIncome,
            totalExpenses: dashboard.totalExpenses,
          ),
          SizedBox(height: 24.h),
          SavingsGoalsWidget(
            goals: const [
              GoalData(
                title: 'Vacation in Bali',
                targetAmount: 4000,
                savedAmount: 3000,
                progress: 0.75,
                icon: Icons.beach_access_rounded,
              ),
              GoalData(
                title: 'New Car',
                targetAmount: 25000,
                savedAmount: 8500,
                progress: 0.34,
                icon: Icons.directions_car_rounded,
              ),
            ],
            onTap: () => context.push('/goals'),
          ),
          SizedBox(height: 24.h),
          _buildViewInsights(context),
          SizedBox(height: 24.h),
          _buildQuickActions(context),
          SizedBox(height: 24.h),
          _buildRecentTransactions(context),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(DashboardEntity dashboard) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'SUMMARY',
          variant: AppTextVariant.caption,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: 'Balance',
                value: dashboard.currentBalance,
                icon: Icons.account_balance_wallet,
                color: dashboard.currentBalance >= 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: 'Income',
                value: dashboard.totalIncome,
                icon: Icons.arrow_downward,
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SummaryCard(
                title: 'Expenses',
                value: dashboard.totalExpenses,
                icon: Icons.arrow_upward,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildViewInsights(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/insights'),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.insights, color: AppColors.primary, size: 24.w),
                SizedBox(width: 12.w),
                AppText(
                  text: 'View Detailed Insights',
                  variant: AppTextVariant.body,
                  color: AppColors.primary,
                ),
              ],
            ),
            Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: greeting,
              variant: AppTextVariant.label,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 4.h),
            AppText(text: 'Your Finances', variant: AppTextVariant.headline),
          ],
        ),
        IconButton(
          icon: Icon(Icons.logout, color: AppColors.textSecondary),
          onPressed: () => _showLogoutDialog(context),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AuthCubit>().signOut();
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
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
                text: 'Add',
                icon: Icons.add_rounded,
                onPressed: () => context.push('/transactions/add'),
                isFullWidth: true,
              ),
            ),
            SizedBox(width: 10.w),
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
            AppText(text: 'Recent Transactions', variant: AppTextVariant.title),
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag_rounded),
              label: 'Goals',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insights_rounded),
              label: 'Insights',
            ),
          ],
        ),
      ),
    );
  }
}
