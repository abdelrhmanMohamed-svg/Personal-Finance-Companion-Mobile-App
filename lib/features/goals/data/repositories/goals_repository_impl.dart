import '../../domain/entities/budget.dart';
import '../../domain/entities/savings_goal.dart';
import '../../domain/entities/streak.dart';
import '../../domain/repositories/goals_repository.dart';
import '../models/budget_model.dart';
import '../models/savings_goal_model.dart';
import '../models/streak_model.dart';
import '../datasources/goals_datasource.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsDataSource _dataSource;

  GoalsRepositoryImpl(this._dataSource);

  @override
  Future<List<Budget>> getBudgets(String userId) async {
    final data = await _dataSource.getBudgets(userId);
    return data.map((map) => BudgetModel.fromMap(map).toEntity()).toList();
  }

  @override
  Future<Budget?> getBudgetById(String id, String userId) async {
    final data = await _dataSource.getBudgetById(id, userId);
    if (data == null) return null;
    return BudgetModel.fromMap(data).toEntity();
  }

  @override
  Future<Budget?> getCurrentBudget(String userId) async {
    final data = await _dataSource.getCurrentBudget(userId);
    if (data == null) return null;
    return BudgetModel.fromMap(data).toEntity();
  }

  @override
  Future<Budget> createBudget(Budget budget) async {
    final model = BudgetModel.fromEntity(budget);
    final data = model.toMap()..remove('id');
    final result = await _dataSource.createBudget(data);
    return BudgetModel.fromMap(result).toEntity();
  }

  @override
  Future<Budget> updateBudget(Budget budget) async {
    final model = BudgetModel.fromEntity(budget);
    final data = model.toMap()..remove('id');
    final result =
        await _dataSource.updateBudget(budget.id, budget.userId, data);
    return BudgetModel.fromMap(result).toEntity();
  }

  @override
  Future<void> deleteBudget(String id, String userId) async {
    await _dataSource.deleteBudget(id, userId);
  }

  @override
  Future<void> updateBudgetSpending(String userId) async {
    final budgets = await getBudgets(userId);
    final now = DateTime.now();

    for (final budget in budgets) {
      if (budget.periodStart.isAfter(now) || budget.periodEnd.isBefore(now)) {
        continue;
      }

      final transactions = await _dataSource.getTransactionsForPeriod(
        userId,
        'expense',
        budget.periodStart,
        budget.periodEnd,
        category: budget.category,
      );

      double totalSpent = 0;
      for (final t in transactions) {
        totalSpent += (t['amount'] as num).toDouble();
      }

      await updateBudget(budget.copyWith(
        currentSpent: totalSpent,
        updatedAt: DateTime.now(),
      ));
    }
  }

  @override
  Future<List<SavingsGoal>> getSavingsGoals(String userId) async {
    final data = await _dataSource.getSavingsGoals(userId);
    return data.map((map) => SavingsGoalModel.fromMap(map).toEntity()).toList();
  }

  @override
  Future<SavingsGoal?> getSavingsGoalById(String id, String userId) async {
    final data = await _dataSource.getSavingsGoalById(id, userId);
    if (data == null) return null;
    return SavingsGoalModel.fromMap(data).toEntity();
  }

  @override
  Future<SavingsGoal> createSavingsGoal(SavingsGoal goal) async {
    final model = SavingsGoalModel.fromEntity(goal);
    final data = model.toMap()..remove('id');
    final result = await _dataSource.createSavingsGoal(data);
    return SavingsGoalModel.fromMap(result).toEntity();
  }

  @override
  Future<SavingsGoal> updateSavingsGoal(SavingsGoal goal) async {
    final model = SavingsGoalModel.fromEntity(goal);
    final data = model.toMap()..remove('id');
    final result =
        await _dataSource.updateSavingsGoal(goal.id, goal.userId, data);
    return SavingsGoalModel.fromMap(result).toEntity();
  }

  @override
  Future<void> deleteSavingsGoal(String id, String userId) async {
    await _dataSource.deleteSavingsGoal(id, userId);
  }

  @override
  Future<void> updateSavingsGoalProgress(String userId) async {
    final goals = await getSavingsGoals(userId);

    for (final goal in goals) {
      if (goal.isCompleted) continue;

      final transactions = await _dataSource.getIncomeTransactionsSince(
        userId,
        goal.createdAt,
      );

      double totalSaved = 0;
      for (final t in transactions) {
        totalSaved += (t['amount'] as num).toDouble();
      }

      final completedAt = totalSaved >= goal.targetAmount && !goal.isCompleted
          ? DateTime.now()
          : goal.completedAt;

      await updateSavingsGoal(goal.copyWith(
        currentSaved: totalSaved,
        completedAt: completedAt,
        updatedAt: DateTime.now(),
      ));
    }
  }

  @override
  Future<Streak?> getStreak(String userId) async {
    final data = await _dataSource.getStreak(userId);
    if (data == null) return null;
    return StreakModel.fromMap(data).toEntity();
  }

  @override
  Future<Streak> createOrUpdateStreak(Streak streak) async {
    final model = StreakModel.fromEntity(streak);
    final data = model.toMap()..remove('id');
    final result = await _dataSource.createOrUpdateStreak(data);
    return StreakModel.fromMap(result).toEntity();
  }

  @override
  Future<void> incrementStreak(String userId) async {
    final streak = await getStreak(userId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (streak == null) {
      await createOrUpdateStreak(Streak(
        id: '',
        userId: userId,
        currentStreak: 1,
        longestStreak: 1,
        lastUpdated: today,
        streakStartDate: today,
      ));
      return;
    }

    final lastUpdated = DateTime(
      streak.lastUpdated.year,
      streak.lastUpdated.month,
      streak.lastUpdated.day,
    );

    if (lastUpdated.isAtSameMomentAs(today)) {
      return;
    }

    final newStreak = streak.currentStreak + 1;
    final newLongest =
        newStreak > streak.longestStreak ? newStreak : streak.longestStreak;

    await createOrUpdateStreak(streak.copyWith(
      currentStreak: newStreak,
      longestStreak: newLongest,
      lastUpdated: today,
    ));
  }

  @override
  Future<void> resetStreak(String userId) async {
    final streak = await getStreak(userId);

    if (streak == null) return;

    await createOrUpdateStreak(streak.copyWith(
      currentStreak: 0,
      lastUpdated: DateTime.now(),
    ));
  }
}
