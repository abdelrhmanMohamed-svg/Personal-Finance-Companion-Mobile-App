import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_constants.dart';
import '../../../../core/services/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_nav_bar.dart';
import '../../../../shared/widgets/app_custom_app_bar.dart';
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
    final brightness = Theme.of(context).brightness;
    final surface = brightness == Brightness.dark ? AppColorsDark.surface : AppColors.surface;
    final textPrimary = brightness == Brightness.dark ? AppColorsDark.textPrimary : AppColors.textPrimary;
    final textSecondary = brightness == Brightness.dark ? AppColorsDark.textSecondary : AppColors.textSecondary;

    return BlocProvider(
      create: (_) => getIt<InsightsCubit>()..loadInsights(),
      child: Builder(
        builder: (ctx) {
          return Scaffold(
            backgroundColor: surface,
            appBar: AppCustomAppBar(title: 'Insights'),
            body: BlocBuilder<InsightsCubit, InsightsState>(
              buildWhen: (previous, current) {
                return previous.runtimeType != current.runtimeType;
              },
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
                    onAction: () => context.push(AppRoutes.transactionAdd),
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
                          _buildSectionTitle('Spending by Category', textPrimary),
                          SizedBox(height: 16.h),
                          CategoryPieChart(
                            categories: categories,
                            topCategory: topCategory.category,
                          ),
                          SizedBox(height: 16.h),
                          CategoryLegend(categories: categories),
                          SizedBox(height: 24.h),
                          _buildSectionTitle('Weekly Comparison', textPrimary),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'This Week: \$${state.weeklyComparison.currentWeekTotal.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 14, color: textPrimary),
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
                              color: textSecondary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          WeeklyComparisonChart(
                            comparison: state.weeklyComparison,
                          ),
                          SizedBox(height: 24.h),
                          _buildSectionTitle('Monthly Trends', textPrimary),
                          SizedBox(height: 16.h),
                          if (state.monthlyTrends.length < 2)
                            Text(
                              'Add more transactions to see trends',
                              style: TextStyle(color: textSecondary),
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
            bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textPrimary) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
    );
  }
}
