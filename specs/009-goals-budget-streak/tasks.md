# Tasks: Goals Feature (Budget Tracker + Savings Goals + Saving Streak)

**Feature**: Budget Tracker + Savings Goals + Saving Streak  
**Branch**: `009-goals-budget-streak`  
**Phase**: 6  
**Generated**: 2026-04-05

## Task Summary

| Phase | Description | Task Count |
|-------|-------------|------------|
| Phase 1 | Setup (Supabase Migration) | 3 |
| Phase 2 | Foundational (Data Layer) | 6 |
| Phase 3 | User Story 1 - Budget Setup & Tracking | 7 |
| Phase 4 | User Story 2 - Category Budgets | 4 |
| Phase 5 | User Story 3 - Streak Tracking | 5 |
| Phase 6 | User Story 4 - Monthly Reset | 3 |
| Phase 7 | User Story 5 - Savings Goals | 5 |
| Phase 8 | Polish & Integration | 4 |
| **Total** | | **37** |

## Supabase Configuration

**Project URL**: `https://vzqaguiustzukunpdvpv.supabase.co`

## Phase 1: Setup

- [X] T001 Create Supabase migration file for budgets, savings_goals, and streaks tables in migrations/001_goals_tables.sql
- [X] T002 Apply migration to Supabase using: `supabase db push` or SQL Editor
- [X] T003 Verify tables created with correct schema in Supabase dashboard

## Phase 2: Foundational

- [X] T004 [P] Create Budget entity in lib/features/goals/domain/entities/budget.dart
- [X] T005 [P] Create SavingsGoal entity in lib/features/goals/domain/entities/savings_goal.dart
- [X] T006 [P] Create Streak entity in lib/features/goals/domain/entities/streak.dart
- [X] T007 Create Budget model (data layer) in lib/features/goals/data/models/budget_model.dart
- [X] T008 Create SavingsGoal model in lib/features/goals/data/models/savings_goal_model.dart
- [X] T009 Create Streak model in lib/features/goals/data/models/streak_model.dart

## Phase 3: User Story 1 - Set and Track Monthly Budget (P1)

**Independent Test**: Can be tested by setting a budget, logging expenses, and verifying budget progress updates correctly.

- [X] T010 [US1] Create GoalsRepository interface in lib/features/goals/domain/repositories/goals_repository.dart
- [X] T011 [US1] Implement GoalsRepository in lib/features/goals/data/repositories/goals_repository_impl.dart
- [X] T012 [US1] Create CreateBudget use case in lib/features/goals/domain/usecases/create_budget.dart
- [X] T013 [US1] Create GetBudgets use case in lib/features/goals/domain/usecases/get_budgets.dart
- [X] T014 [US1] Create UpdateSpending use case in lib/features/goals/domain/usecases/update_spending.dart
- [X] T015 [US1] Create GoalsCubit in lib/features/goals/presentation/cubit/goals_cubit.dart
- [X] T016 [US1] Create GoalsState in lib/features/goals/presentation/cubit/goals_state.dart

## Phase 4: User Story 2 - Category-Specific Budget (P2)

**Independent Test**: Can be tested by setting a budget for a specific category, logging transactions in that category, and verifying progress updates correctly.

- [X] T017 [US2] Add category parameter support to CreateBudget use case
- [X] T018 [US2] Add category filtering to GetBudgets use case
- [X] T019 [US2] Update repository to handle category-specific budget calculations
- [X] T020 [US2] Add category list to GoalsCubit state

## Phase 5: User Story 3 - Saving Streak Tracking (P2)

**Independent Test**: Can be tested by maintaining spending within budget for multiple days and verifying the streak counter increases appropriately.

- [X] T021 [US3] Create GetStreak use case in lib/features/goals/domain/usecases/get_streak.dart
- [X] T022 [US3] Create UpdateStreak use case in lib/features/goals/domain/usecases/update_streak.dart
- [X] T023 [US3] Implement streak increment logic in repository
- [X] T024 [US3] Implement streak reset logic in repository
- [X] T025 [US3] Add streak tracking to GoalsCubit

## Phase 6: User Story 4 - Budget Period Management (P3)

**Independent Test**: Can be tested by setting a budget, progressing through the month, and verifying that at the new month the budget resets with fresh tracking.

- [X] T026 [US4] Implement monthly reset logic in UpdateSpending use case
- [X] T027 [US4] Add period_start and period_end handling to Budget model
- [X] T028 [US4] Add automatic reset check on app start

## Phase 7: User Story 5 - Set Savings Goal (P2)

**Independent Test**: Can be tested by creating a savings goal, logging income, and verifying progress towards target.

- [X] T029 [US5] Create CreateSavingsGoal use case in lib/features/goals/domain/usecases/create_savings_goal.dart
- [X] T030 [US5] Create GetSavingsGoals use case in lib/features/goals/domain/usecases/get_savings_goals.dart
- [X] T031 [US5] Implement goal progress calculation from income transactions
- [X] T032 [US5] Add goal completion detection logic
- [X] T033 [US5] Add SavingsGoal state and handling to GoalsCubit

## Phase 8: Polish & Integration

- [X] T034 Add budget warning (80%) and alert (exceeded) UI indicators
- [X] T035 Add streak display widget to dashboard
- [X] T036 Add goal completion celebration UI
- [X] T037 Integrate Goals feature with Transactions feature (auto-update on transaction add)

## Dependencies

```
US1 (Budget Setup) ──┬──► Phase 1 (Setup)
                     │    Phase 2 (Foundational)
US2 (Category Budgets) ──► Depends on US1
US3 (Streak Tracking) ──► Depends on US1
US4 (Monthly Reset) ──► Depends on US1, US3
US5 (Savings Goals) ──► Depends on US1
```

## Parallel Opportunities

| Tasks | Can Run In Parallel Because |
|-------|----------------------------|
| T004-T006 | Different entity files, no dependencies |
| T007-T009 | Different model files, no dependencies |
| T010-T014 | Different use case files, no dependencies |
| T017-T020 | Additions to existing US1 code |
| T021-T025 | Streak-specific code, can parallel with US2 work |

## MVP Scope

**Recommended MVP**: User Story 1 (Budget Setup & Tracking)
- Tasks: T001-T016
- Delivers: Core budget creation and progress tracking
- Independent test: Set budget → add expenses → see progress

## Migration File Content

File: `migrations/001_goals_tables.sql`

```sql
-- Migration: Create goals tables
-- Created: 2026-04-05

-- Budgets table
CREATE TABLE IF NOT EXISTS budgets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  category VARCHAR(100) NULL,
  limit_amount DECIMAL(12,2) NOT NULL CHECK (limit_amount > 0),
  current_spent DECIMAL(12,2) NOT NULL DEFAULT 0,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  is_deleted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Savings Goals table
CREATE TABLE IF NOT EXISTS savings_goals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  target_amount DECIMAL(12,2) NOT NULL CHECK (target_amount > 0),
  current_saved DECIMAL(12,2) NOT NULL DEFAULT 0,
  is_deleted BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Streaks table
CREATE TABLE IF NOT EXISTS streaks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  current_streak INTEGER NOT NULL DEFAULT 0,
  longest_streak INTEGER NOT NULL DEFAULT 0,
  last_updated DATE NOT NULL,
  streak_start_date DATE
);

-- Row Level Security (RLS)
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE savings_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE streaks ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can manage own budgets" ON budgets
  FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users can manage own savings goals" ON savings_goals
  FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users can manage own streaks" ON streaks
  FOR ALL USING (auth.uid() = user_id);
```

## Push Migration to Supabase

```bash
# Option 1: Using Supabase CLI
supabase db push --project-ref vzqaguiustzukunpdvpv

# Option 2: Paste SQL in Supabase SQL Editor
# Navigate to: https://supabase.com/dashboard/project/vzqaguiustzukunpdvpv/sql-editor
# Copy and execute the migration SQL above
```