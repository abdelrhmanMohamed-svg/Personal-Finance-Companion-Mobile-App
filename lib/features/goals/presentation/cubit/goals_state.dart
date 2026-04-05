import 'package:equatable/equatable.dart';
import '../../domain/entities/budget.dart';
import '../../domain/entities/savings_goal.dart';
import '../../domain/entities/streak.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object?> get props => [];
}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  final List<Budget> budgets;
  final List<SavingsGoal> savingsGoals;
  final Streak? streak;
  final Budget? currentBudget;

  const GoalsLoaded({
    required this.budgets,
    required this.savingsGoals,
    this.streak,
    this.currentBudget,
  });

  double get totalSaved => savingsGoals.fold(
        0,
        (sum, goal) => sum + goal.currentSaved,
      );

  @override
  List<Object?> get props => [budgets, savingsGoals, streak, currentBudget];

  GoalsLoaded copyWith({
    List<Budget>? budgets,
    List<SavingsGoal>? savingsGoals,
    Streak? streak,
    Budget? currentBudget,
  }) {
    return GoalsLoaded(
      budgets: budgets ?? this.budgets,
      savingsGoals: savingsGoals ?? this.savingsGoals,
      streak: streak ?? this.streak,
      currentBudget: currentBudget ?? this.currentBudget,
    );
  }
}

class GoalsError extends GoalsState {
  final String message;

  const GoalsError(this.message);

  @override
  List<Object> get props => [message];
}

class GoalsEmpty extends GoalsState {}

class GoalCompleted extends GoalsState {
  final String goalName;
  final List<SavingsGoal> goals;

  const GoalCompleted({
    required this.goalName,
    required this.goals,
  });

  @override
  List<Object> get props => [goalName, goals];
}
