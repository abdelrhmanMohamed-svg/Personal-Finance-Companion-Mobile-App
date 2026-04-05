# Data Model: Goals Feature

**Feature**: Budget Tracker + Savings Goals + Saving Streak  
**Phase**: 6  
**Last Updated**: 2026-04-05

## Entities

### Budget

Represents a spending limit set by the user (monthly or category-specific).

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | UUID | Primary Key, Auto-generated | Unique identifier |
| user_id | UUID | NOT NULL, Foreign Key | References auth.users |
| category | String | NULLABLE | Category name for category budgets, NULL for total budget |
| limit_amount | DECIMAL(12,2) | NOT NULL, > 0 | Budget limit amount |
| current_spent | DECIMAL(12,2) | NOT NULL, DEFAULT 0 | Amount spent in current period |
| period_start | DATE | NOT NULL | Start date of budget period (month) |
| period_end | DATE | NOT NULL | End date of budget period (month) |
| created_at | TIMESTAMP | NOT NULL, DEFAULT now() | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT now() | Last update timestamp |

**Relationships**:
- Belongs to User (via user_id)
- Optional: linked to Transaction category

**State Transitions**:
- Active: budget is current and being tracked
- Expired: period_end has passed, awaiting reset
- Deleted: soft-deleted (is_deleted flag)

### SavingsGoal

Represents a savings target the user wants to achieve.

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | UUID | Primary Key, Auto-generated | Unique identifier |
| user_id | UUID | NOT NULL, Foreign Key | References auth.users |
| name | VARCHAR(255) | NOT NULL | Goal name/description |
| target_amount | DECIMAL(12,2) | NOT NULL, > 0 | Target amount to save |
| current_saved | DECIMAL(12,2) | NOT NULL, DEFAULT 0 | Amount saved towards goal |
| created_at | TIMESTAMP | NOT NULL, DEFAULT now() | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT now() | Last update timestamp |
| completed_at | TIMESTAMP | NULLABLE | When goal was reached |

**Relationships**:
- Belongs to User (via user_id)

**State Transitions**:
- In Progress: current_saved < target_amount
- Completed: current_saved >= target_amount (completed_at set)
- Deleted: soft-deleted (is_deleted flag)

### Streak

Tracks consecutive days of staying within budget.

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | UUID | Primary Key, Auto-generated | Unique identifier |
| user_id | UUID | NOT NULL, Unique | References auth.users |
| current_streak | INTEGER | NOT NULL, DEFAULT 0 | Consecutive days within budget |
| longest_streak | INTEGER | NOT NULL, DEFAULT 0 | Highest streak achieved |
| last_updated | DATE | NOT NULL | Last streak update |
| streak_start_date | DATE | NULLABLE | When current streak began |

**Relationships**:
- Belongs to User (via user_id)

## Database Tables (Supabase SQL)

```sql
-- Budgets table
CREATE TABLE budgets (
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
CREATE TABLE savings_goals (
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
CREATE TABLE streaks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  current_streak INTEGER NOT NULL DEFAULT 0,
  longest_streak INTEGER NOT NULL DEFAULT 0,
  last_updated DATE NOT NULL,
  streak_start_date DATE
);

-- Row Level Security (RLS) - all tables
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

## Validation Rules

From functional requirements:

1. **FR-001**: Budget/savings goal amounts must be > 0
2. **FR-003**: Warning at 80% threshold
3. **FR-004**: Alert when exceeded
4. **FR-010**: Monthly reset of current_spent
5. **FR-011/FR-018**: Edit capability
6. **FR-012/FR-019**: Delete capability (soft delete)
7. **FR-020**: Completion indicator when target reached

## Integration with Transaction Data

The Budget and SavingsGoal entities reference Transaction data from Phase 4:

- **Budget spending**: Sum of expense transactions where:
  - transaction.user_id = budget.user_id
  - transaction.type = 'expense'
  - transaction.category = budget.category (or all expenses for total budget)
  - transaction.date BETWEEN budget.period_start AND budget.period_end

- **Goal progress**: Sum of income transactions where:
  - transaction.user_id = savings_goal.user_id
  - transaction.type = 'income'
  - transaction.date >= savings_goal.created_at