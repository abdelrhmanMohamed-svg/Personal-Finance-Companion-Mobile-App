import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../cubit/insights_cubit.dart';
import '../cubit/insights_state.dart';
import '../widgets/category_legend.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/monthly_trends_chart.dart';
import '../widgets/top_category_card.dart';
import '../widgets/trend_indicator.dart';
import '../widgets/weekly_comparison_chart.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InsightsCubit>()..loadInsights(),
      child: Builder(
        builder: (ctx) {
          return Scaffold(
            appBar: AppBar(
              leading: SizedBox.shrink(),
              title: const Text('Insights'),
              backgroundColor: AppColors.surface,
              elevation: 0,
            ),
            body: BlocBuilder<InsightsCubit, InsightsState>(
              builder: (context, state) {
                if (state is InsightsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is InsightsEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.insights_outlined,
                    title: 'No Insights Yet',
                    message: 'Add some transactions to see your spending insights.',
                    actionLabel: 'Add Transaction',
                    onAction: () => context.push('/transactions/add'),
                  );
                }

                if (state is InsightsError) {
                  return ErrorStateWidget(
                    title: 'Unable to Load Insights',
                    message: state.message,
                    actionLabel: 'Try Again',
                    onAction: () =>
                        context.read<InsightsCubit>().refreshInsights(),
                  );
                }

                if (state is InsightsLoaded) {
                  final categories = state.categoryBreakdown;
                  final topCategory = state.topCategory;

                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<InsightsCubit>().refreshInsights(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (topCategory.category.isNotEmpty) ...[
                            TopCategoryCard(topCategory: topCategory),
                            SizedBox(height: 24.h),
                          ],
                          _buildSectionTitle('Spending by Category'),
                          SizedBox(height: 16.h),
                          CategoryPieChart(
                            categories: categories,
                            topCategory: topCategory.category,
                          ),
                          SizedBox(height: 16.h),
                          CategoryLegend(categories: categories),
                          SizedBox(height: 24.h),
                          _buildSectionTitle('Weekly Comparison'),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'This Week: \$${state.weeklyComparison.currentWeekTotal.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              TrendIndicator(
                                comparison: state.weeklyComparison,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Last Week: \$${state.weeklyComparison.previousWeekTotal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          WeeklyComparisonChart(
                            comparison: state.weeklyComparison,
                          ),
                          SizedBox(height: 24.h),
                          _buildSectionTitle('Monthly Trends'),
                          SizedBox(height: 16.h),
                          if (state.monthlyTrends.length < 2)
                            Text(
                              'Add more transactions to see trends',
                              style: TextStyle(color: Colors.grey.shade600),
                            )
                          else
                            MonthlyTrendsChart(trends: state.monthlyTrends),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            bottomNavigationBar: _buildBottomNav(ctx),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,
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
          currentIndex: 3,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/dashboard');
                break;
              case 1:
                context.push('/transactions');
                break;
              case 2:
                context.push('/goals');
                break;
              case 3:
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
