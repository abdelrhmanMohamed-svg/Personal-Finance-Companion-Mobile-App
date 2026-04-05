# Quickstart: Goals Feature Implementation

**Feature**: Budget Tracker + Savings Goals + Saving Streak  
**Phase**: 6  
**Last Updated**: 2026-04-05

## Prerequisites

- Flutter 3.x with Dart 3.x
- Supabase project configured
- Phase 4 (Transactions) completed and tested

## Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  supabase_flutter: ^2.0.0
  equatable: ^2.0.5
  get_it: ^7.6.4
  intl: ^0.18.1
```

## Implementation Steps

### Step 1: Database Setup

Run the SQL from `data-model.md` in your Supabase SQL editor to create:
- `budgets` table
- `savings_goals` table  
- `streaks` table
- RLS policies

### Step 2: Data Layer

Create the feature structure:

```
lib/features/goals/
├── data/
│   ├── models/
│   │   ├── budget_model.dart
│   │   ├── savings_goal_model.dart
│   │   └── streak_model.dart
│   ├── repositories/
│   │   └── goals_repository_impl.dart
│   └── datasources/
│       └── goals_remote_datasource.dart
├── domain/
│   ├── entities/
│   │   ├── budget.dart
│   │   ├── savings_goal.dart
│   │   └── streak.dart
│   ├── repositories/
│   │   └── goals_repository.dart
│   └── usecases/
│       ├── create_budget.dart
│       ├── get_budgets.dart
│       ├── update_spending.dart
│       ├── create_savings_goal.dart
│       └── update_streak.dart
└── presentation/
    ├── cubit/
    │   ├── goals_cubit.dart
    │   └── goals_state.dart
    ├── pages/
    │   ├── goals_page.dart
    │   ├── budget_detail_page.dart
    │   └── savings_goal_page.dart
    └── widgets/
        ├── budget_card.dart
        ├── progress_indicator.dart
        └── streak_display.dart
```

### Step 3: Cubit Implementation

```dart
// Example state structure
abstract class GoalsState extends Equatable {}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  final List<Budget> budgets;
  final List<SavingsGoal> savingsGoals;
  final Streak? streak;
  
  // Computed properties
  double get totalBudgetSpent;
  double get totalBudgetLimit;
  List<SavingsGoal> get activeGoals;
}

class GoalsError extends GoalsState {
  final String message;
}
```

### Step 4: UI Components

Key UI widgets needed:
- `BudgetCard` - displays budget with progress bar
- `SavingsGoalCard` - displays goal with progress
- `StreakBadge` - shows current streak count
- `BudgetProgressBar` - visual indicator (green/yellow/red)
- `GoalCompletionBadge` - celebration when goal reached

### Step 5: Integration with Transactions

Update streak calculation when transactions are added:

```dart
Future<void> checkAndUpdateStreak() async {
  final today = DateTime.now();
  final totalSpent = await getTodaySpending();
  final budget = await getCurrentBudget();
  
  if (totalSpent > budget.limitAmount) {
    // Budget exceeded - reset streak
    await resetStreak();
  } else {
    // Within budget - increment if not already done today
    await incrementStreakIfNeeded();
  }
}
```

## Testing

```bash
# Run tests
flutter test

# Run specific feature tests
flutter test test/unit/goals/
flutter test test/widget/goals/
```

## Verification

Verify implementation against `spec.md`:

1. Budget setup works (FR-001)
2. Progress displays correctly (FR-002)
3. Warning at 80% threshold (FR-003)
4. Alert when exceeded (FR-004)
5. Category budgets work (FR-005, FR-006)
6. Streak tracking works (FR-007 to FR-009)
7. Monthly reset works (FR-010)
8. Edit/Delete budgets (FR-011, FR-012)
9. Savings goals work (FR-015 to FR-020)

## Common Issues

1. **Streak not updating**: Ensure streak check runs after every transaction
2. **Budget progress stale**: Use Supabase realtime or manual refresh after transaction add
3. **Monthly reset timing**: Use server time or local timezone consistently