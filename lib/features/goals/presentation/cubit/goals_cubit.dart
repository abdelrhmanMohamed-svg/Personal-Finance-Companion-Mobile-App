import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/budget.dart';
import '../../domain/entities/savings_goal.dart';
import '../../domain/repositories/goals_repository.dart';
import 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  final GoalsRepository _goalsRepository;
  final SupabaseClient _supabaseClient;

  GoalsCubit({
    required GoalsRepository goalsRepository,
    required SupabaseClient supabaseClient,
  })  : _goalsRepository = goalsRepository,
        _supabaseClient = supabaseClient,
        super(GoalsInitial());

  void loadGoals() {
    emit(GoalsLoading());
    _fetchGoals();
  }

  void refreshGoals() {
    _fetchGoals();
  }

  Future<void> _fetchGoals() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        emit(GoalsError('User not authenticated'));
        return;
      }

      final budgets = await _goalsRepository.getBudgets(userId);
      final savingsGoals = await _goalsRepository.getSavingsGoals(userId);
      final streak = await _goalsRepository.getStreak(userId);
      final currentBudget = await _goalsRepository.getCurrentBudget(userId);

      if (budgets.isEmpty && savingsGoals.isEmpty) {
        emit(GoalsEmpty());
      } else {
        emit(GoalsLoaded(
          budgets: budgets,
          savingsGoals: savingsGoals,
          streak: streak,
          currentBudget: currentBudget,
        ));
      }
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> createSavingsGoal({
    required String name,
    required double targetAmount,
    String? icon,
  }) async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        emit(GoalsError('User not authenticated'));
        return;
      }

      final now = DateTime.now();
      final goal = SavingsGoal(
        id: '',
        userId: userId,
        name: name,
        targetAmount: targetAmount,
        currentSaved: 0,
        createdAt: now,
        updatedAt: now,
      );

      await _goalsRepository.createSavingsGoal(goal);
      await _fetchGoals();
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> addToSavingsGoal(String goalId, double amount) async {
    try {
      final currentState = state;
      if (currentState is! GoalsLoaded) return;

      final goal = currentState.savingsGoals.firstWhere(
        (g) => g.id == goalId,
      );

      final newSavedAmount = goal.currentSaved + amount;
      final wasNotCompleted = !goal.isCompleted;
      final isNowCompleted = newSavedAmount >= goal.targetAmount;

      final updatedGoal = await _goalsRepository.updateSavingsGoal(
        goal.copyWith(
          currentSaved: newSavedAmount,
          completedAt: isNowCompleted && wasNotCompleted
              ? DateTime.now()
              : goal.completedAt,
          updatedAt: DateTime.now(),
        ),
      );

      final List<SavingsGoal> updatedGoals = currentState.savingsGoals
          .map((g) {
            return g.id == goalId ? updatedGoal : g;
          })
          .cast<SavingsGoal>()
          .toList();

      emit(currentState.copyWith(savingsGoals: updatedGoals));

      if (wasNotCompleted && isNowCompleted) {
        emit(GoalCompleted(goalName: goal.name, goals: updatedGoals));
      }
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> deleteSavingsGoal(String goalId) async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      await _goalsRepository.deleteSavingsGoal(goalId, userId);

      final currentState = state;
      if (currentState is GoalsLoaded) {
        final updatedGoals =
            currentState.savingsGoals.where((g) => g.id != goalId).toList();
        emit(currentState.copyWith(savingsGoals: updatedGoals));
      }
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> updateSavingsGoal(
    String goalId,
    String name,
    double targetAmount,
  ) async {
    try {
      final currentState = state;
      if (currentState is! GoalsLoaded) return;

      final goal = currentState.savingsGoals.firstWhere(
        (g) => g.id == goalId,
      );

      final updatedGoal = await _goalsRepository.updateSavingsGoal(
        goal.copyWith(
          name: name,
          targetAmount: targetAmount,
          updatedAt: DateTime.now(),
        ),
      );

      final updatedGoals = currentState.savingsGoals.map((g) {
        return g.id == goalId ? updatedGoal : g;
      }).toList();

      emit(currentState.copyWith(
          savingsGoals: updatedGoals.cast<SavingsGoal>()));
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> createBudget({
    required double amount,
    String? category,
  }) async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        emit(GoalsError('User not authenticated'));
        return;
      }

      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      final budget = Budget(
        id: '',
        userId: userId,
        limitAmount: amount,
        currentSpent: 0,
        category: category,
        periodStart: startOfMonth,
        periodEnd: endOfMonth,
        isDeleted: false,
        createdAt: now,
        updatedAt: now,
      );

      final createdBudget = await _goalsRepository.createBudget(budget);

      final currentState = state;
      if (currentState is GoalsLoaded) {
        emit(currentState.copyWith(
          budgets: [...currentState.budgets, createdBudget],
          currentBudget: currentState.currentBudget ?? createdBudget,
        ));
      }
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }

  Future<void> recordStreak() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      await _goalsRepository.incrementStreak(userId);
      final streak = await _goalsRepository.getStreak(userId);

      final currentState = state;
      if (currentState is GoalsLoaded) {
        emit(currentState.copyWith(streak: streak));
      }
    } catch (e) {
      emit(GoalsError(e.toString()));
    }
  }
}
