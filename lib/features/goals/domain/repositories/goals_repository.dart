import '../entities/budget.dart';
import '../entities/savings_goal.dart';
import '../entities/streak.dart';

abstract class GoalsRepository {
  // Budget operations
  Future<List<Budget>> getBudgets(String userId);
  Future<Budget?> getBudgetById(String id, String userId);
  Future<Budget?> getCurrentBudget(String userId);
  Future<Budget> createBudget(Budget budget);
  Future<Budget> updateBudget(Budget budget);
  Future<void> deleteBudget(String id, String userId);
  Future<void> updateBudgetSpending(String userId);

  // Savings Goal operations
  Future<List<SavingsGoal>> getSavingsGoals(String userId);
  Future<SavingsGoal?> getSavingsGoalById(String id, String userId);
  Future<SavingsGoal> createSavingsGoal(SavingsGoal goal);
  Future<SavingsGoal> updateSavingsGoal(SavingsGoal goal);
  Future<void> deleteSavingsGoal(String id, String userId);
  Future<void> updateSavingsGoalProgress(String userId);

  // Streak operations
  Future<Streak?> getStreak(String userId);
  Future<Streak> createOrUpdateStreak(Streak streak);
  Future<void> incrementStreak(String userId);
  Future<void> resetStreak(String userId);
}
