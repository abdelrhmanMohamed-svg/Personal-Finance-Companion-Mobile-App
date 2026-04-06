import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_nav_bar.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_custom_app_bar.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../cubit/goals_cubit.dart';
import '../cubit/goals_state.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<GoalsCubit>()..loadGoals(),
      child: const _GoalsScreenContent(),
    );
  }
}

class _GoalsScreenContent extends StatelessWidget {
  const _GoalsScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'Savings Goals',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _showAddGoalDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<GoalsCubit, GoalsState>(
        listenWhen: (previous, current) => current is GoalCompleted,
        listener: (context, state) {
          if (state is GoalCompleted) {
            _showGoalCompletedDialog(context, state.goalName);
          }
        },
        buildWhen: (previous, current) {
          return previous.runtimeType != current.runtimeType;
        },
        builder: (context, state) {
          if (state is GoalsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GoalsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: state.message, variant: AppTextVariant.body),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => context.read<GoalsCubit>().loadGoals(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is GoalsEmpty || state is GoalsInitial) {
            return _buildEmptyState(context);
          }

          if (state is GoalsLoaded) {
            return _buildContent(context, state);
          }
          
          if (state is GoalCompleted) {
            return _buildContent(context, GoalsLoaded(
              budgets: const [],
              savingsGoals: state.goals,
            ));
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.flag_rounded,
      title: 'No Goals Yet',
      message: 'Create your first savings goal!',
      actionLabel: 'Add Goal',
      onAction: () => _showAddGoalDialog(context),
    );
  }

  Widget _buildContent(BuildContext context, GoalsLoaded state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalSavings(state.totalSaved),
          if (state.streak != null) ...[
            SizedBox(height: 24.h),
            _buildStreakCard(state.streak!.currentStreak),
          ],
          SizedBox(height: 24.h),
          _buildGoalsSection(context, state),
        ],
      ),
    );
  }

  Widget _buildTotalSavings(double totalSaved) {
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
              Icon(
                Icons.savings_rounded,
                color: AppColors.onSecondary,
                size: 24.w,
              ),
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
            text: '\$${totalSaved.toStringAsFixed(2)}',
            variant: AppTextVariant.headline,
            color: AppColors.onSecondary,
            fontSize: 32.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(int streak) {
    return AppCard(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.tertiary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.tertiary,
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
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection(BuildContext context, GoalsLoaded state) {
    if (state.savingsGoals.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            children: [
              Icon(
                Icons.savings_outlined,
                size: 48.w,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 16.h),
              AppText(
                text: 'No savings goals yet',
                variant: AppTextVariant.body,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: 'Your Goals', variant: AppTextVariant.title),
        SizedBox(height: 16.h),
        ...state.savingsGoals.map(
          (goal) => _buildGoalCard(
            context: context,
            goalId: goal.id,
            title: goal.name,
            targetAmount: '\$${goal.targetAmount.toStringAsFixed(2)}',
            savedAmount: '\$${goal.currentSaved.toStringAsFixed(2)}',
            progress: goal.progressPercentage.clamp(0.0, 1.0),
            icon: Icons.flag_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCard({
    required BuildContext context,
    required String goalId,
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
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
                onSelected: (value) {
                  if (value == 'add') {
                    _showAddToGoalDialog(context, goalId, title);
                  } else if (value == 'edit') {
                    _showEditGoalDialog(context, goalId, title, targetAmount);
                  } else if (value == 'delete') {
                    _confirmDelete(context, goalId);
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'add',
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline, size: 20, color: AppColors.income),
                        SizedBox(width: 8),
                        Text('Add Money'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
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

  void _showAddGoalDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create Savings Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Goal Name'),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Target Amount',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final amount = double.tryParse(amountController.text);
              if (name.isNotEmpty && amount != null && amount > 0) {
                context.read<GoalsCubit>().createSavingsGoal(
                  name: name,
                  targetAmount: amount,
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAddToGoalDialog(BuildContext context, String goalId, String goalName) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Add to $goalName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null && amount > 0) {
                context.read<GoalsCubit>().addToSavingsGoal(goalId, amount);
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, String goalId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Goal'),
        content: const Text('Are you sure you want to delete this goal?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
              context.read<GoalsCubit>().deleteSavingsGoal(goalId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _showEditGoalDialog(
    BuildContext context,
    String goalId,
    String currentName,
    String currentTargetAmount,
  ) {
    final nameController = TextEditingController(text: currentName);
    final amountController = TextEditingController(
      text: currentTargetAmount.replaceAll('\$', '').replaceAll(',', ''),
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Goal Name'),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Target Amount',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final amount = double.tryParse(amountController.text);
              if (name.isNotEmpty && amount != null && amount > 0) {
                context.read<GoalsCubit>().updateSavingsGoal(
                  goalId,
                  name,
                  amount,
                );
                Navigator.of(dialogContext).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showGoalCompletedDialog(BuildContext context, String goalName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: AppColors.income),
            SizedBox(width: 8),
            Text('Congratulations!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You\'ve reached your savings goal:'),
            SizedBox(height: 8),
            Text(
              goalName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.celebration, color: AppColors.tertiary),
                SizedBox(width: 8),
                Text('Keep up the great work!'),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }
}
