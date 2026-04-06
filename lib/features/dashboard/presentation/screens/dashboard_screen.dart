import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_nav_bar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../goals/presentation/cubit/goals_cubit.dart';
import '../../../goals/presentation/cubit/goals_state.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/income_expense_row.dart';
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

  Color _getColor(Brightness brightness, Color lightColor, Color darkColor) {
    return brightness == Brightness.dark ? darkColor : lightColor;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => GetIt.I<GoalsCubit>()..loadGoals(),
      child: Builder(
        builder: (context) => RefreshIndicator(
          onRefresh: () async {
            context.read<DashboardCubit>().refreshDashboard();
            context.read<GoalsCubit>().refreshGoals();
          },
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            body: SafeArea(
              child: BlocBuilder<DashboardCubit, DashboardState>(
                buildWhen: (previous, current) {
                  return previous.runtimeType != current.runtimeType;
                },
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
                          EmptyStateWidget(
                            icon: Icons.account_balance_wallet_outlined,
                            title: 'Welcome to Your Finance Companion',
                            message:
                                'Start by adding your first transaction to track your finances.',
                            actionLabel: 'Add Transaction',
                            onAction: () =>
                                context.push(AppRoutes.transactionAdd),
                          ),
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
                            title: 'Something Went Wrong',
                            message: state.message,
                            actionLabel: 'Try Again',
                            onAction: () =>
                                context.read<DashboardCubit>().loadDashboard(),
                          ),
                          SizedBox(height: 24.h),
                          _buildQuickActions(context),
                        ],
                      ),
                    );
                  }

                  if (state is DashboardLoaded) {
                    return _buildLoadedContent(
                      context,
                      state.dashboard,
                      state.recentTransactions,
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(
    BuildContext context,
    DashboardEntity dashboard,
    List<Transaction> recentTransactions,
  ) {
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
          BlocBuilder<GoalsCubit, GoalsState>(
            buildWhen: (previous, current) {
              return previous.runtimeType != current.runtimeType;
            },
            builder: (context, goalsState) {
              List<GoalData> goals = [];
              int? streak;

              if (goalsState is GoalsLoaded) {
                goals = goalsState.savingsGoals
                    .take(2)
                    .map(
                      (goal) => GoalData(
                        title: goal.name,
                        targetAmount: goal.targetAmount,
                        savedAmount: goal.currentSaved,
                        progress: goal.progressPercentage.clamp(0.0, 1.0),
                        icon: Icons.flag_rounded,
                      ),
                    )
                    .toList();
                streak = goalsState.streak?.currentStreak;
              }

              return Column(
                children: [
                  if (streak != null && streak > 0) ...[
                    _buildStreakCard(streak),
                    SizedBox(height: 16.h),
                  ],
                  SavingsGoalsWidget(
                    goals: goals,
                    onTap: () => context.push(AppRoutes.goals),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 24.h),
          _buildViewInsights(context),
          SizedBox(height: 24.h),
          _buildQuickActions(context),
          SizedBox(height: 24.h),
          _buildRecentTransactions(context, recentTransactions),
        ],
      ),
    );
  }

  Widget _buildViewInsights(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.insights),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _getColor(
            brightness,
            AppColors.primary,
            AppColorsDark.primary,
          ).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.insights,
                  color: _getColor(
                    brightness,
                    AppColors.primary,
                    AppColorsDark.primary,
                  ),
                  size: 24.w,
                ),
                SizedBox(width: 12.w),
                AppText(
                  text: 'View Detailed Insights',
                  variant: AppTextVariant.body,
                  color: _getColor(
                    brightness,
                    AppColors.primary,
                    AppColorsDark.primary,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: _getColor(
                brightness,
                AppColors.primary,
                AppColorsDark.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(int streak) {
    final brightness = Theme.of(context).brightness;
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: _getColor(
                brightness,
                AppColors.tertiary,
                AppColorsDark.tertiary,
              ).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.local_fire_department_rounded,
              color: _getColor(
                brightness,
                AppColors.tertiary,
                AppColorsDark.tertiary,
              ),
              size: 24.w,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Saving Streak',
                  variant: AppTextVariant.body,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  text: '$streak day${streak != 1 ? 's' : ''} in a row!',
                  variant: AppTextVariant.caption,
                  color: _getColor(
                    brightness,
                    AppColors.textSecondary,
                    AppColorsDark.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final brightness = Theme.of(context).brightness;
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
              color: _getColor(
                brightness,
                AppColors.textSecondary,
                AppColorsDark.textSecondary,
              ),
            ),
            SizedBox(height: 4.h),
            AppText(text: 'Your Finances', variant: AppTextVariant.headline),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: _getColor(
              brightness,
              AppColors.textSecondary,
              AppColorsDark.textSecondary,
            ),
          ),
          onPressed: () => _showDrawer(context),
        ),
      ],
    );
  }

  void _showDrawer(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.settings,
                color: _getColor(
                  brightness,
                  AppColors.primary,
                  AppColorsDark.primary,
                ),
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(ctx);
                context.push(AppRoutes.settings);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: _getColor(
                  brightness,
                  AppColors.error,
                  AppColorsDark.error,
                ),
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: _getColor(
                    brightness,
                    AppColors.error,
                    AppColorsDark.error,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(ctx);
                context.read<AuthCubit>().signOut();
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'QUICK ACTIONS',
          variant: AppTextVariant.caption,
          color: _getColor(
            brightness,
            AppColors.textSecondary,
            AppColorsDark.textSecondary,
          ),
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
                onPressed: () => context.push(AppRoutes.transactionAdd),
                isFullWidth: true,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: AppButton(
                text: 'Set Goal',
                icon: Icons.flag_rounded,
                variant: AppButtonVariant.outlined,
                onPressed: () => context.push(AppRoutes.goals),
                isFullWidth: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentTransactions(
    BuildContext context,
    List<Transaction> transactions,
  ) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(text: 'Recent Transactions', variant: AppTextVariant.title),
            TextButton(
              onPressed: () => context.push(AppRoutes.transactions),
              child: AppText(
                text: 'See All',
                variant: AppTextVariant.label,
                color: _getColor(
                  brightness,
                  AppColors.primary,
                  AppColorsDark.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (transactions.isEmpty)
          AppCard(
            padding: EdgeInsets.all(20.w),
            child: Center(
              child: AppText(
                text: 'No recent transactions',
                variant: AppTextVariant.body,
                color: _getColor(
                  brightness,
                  AppColors.textSecondary,
                  AppColorsDark.textSecondary,
                ),
              ),
            ),
          )
        else
          ...transactions.map((tx) => _buildTransactionItem(tx)),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction tx) {
    final brightness = Theme.of(context).brightness;
    final isIncome = tx.type == TransactionType.income;
    final incomeColor = _getColor(
      brightness,
      AppColors.income,
      AppColorsDark.income,
    );
    final expenseColor = _getColor(
      brightness,
      AppColors.expense,
      AppColorsDark.expense,
    );
    final textSecondaryColor = _getColor(
      brightness,
      AppColors.textSecondary,
      AppColorsDark.textSecondary,
    );
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: (isIncome ? incomeColor : expenseColor).withValues(
                alpha: 0.1,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isIncome
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: isIncome ? incomeColor : expenseColor,
              size: 20.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: tx.category,
                  variant: AppTextVariant.body,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  text: '${tx.date.day}/${tx.date.month}/${tx.date.year}',
                  variant: AppTextVariant.caption,
                  color: textSecondaryColor,
                ),
              ],
            ),
          ),
          AppText(
            text: '${isIncome ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
            variant: AppTextVariant.body,
            fontWeight: FontWeight.w600,
            color: isIncome ? incomeColor : expenseColor,
          ),
        ],
      ),
    );
  }
}
