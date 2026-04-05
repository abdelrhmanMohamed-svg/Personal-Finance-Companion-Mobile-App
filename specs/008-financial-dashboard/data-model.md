# Data Model: Financial Dashboard

**Feature**: 008-financial-dashboard  
**Date**: 2026-04-05

## Entities

### DashboardSummary

Represents the aggregated financial data displayed on the dashboard.

| Field | Type | Description | Validation |
|-------|------|-------------|------------|
| currentBalance | decimal | Total income minus total expenses | Required, calculated |
| totalIncome | decimal | Sum of all income transactions | Required, >= 0 |
| totalExpenses | decimal | Sum of all expense transactions | Required, >= 0 |
| periodStart | date | Start of the viewing period | Required |
| periodEnd | date | End of the viewing period | Required |

### DashboardState (Cubit States)

| State | Description |
|-------|-------------|
| DashboardInitial | Initial state before any data loaded |
| DashboardLoading | Data is being fetched |
| DashboardLoaded | Data successfully loaded with DashboardSummary |
| DashboardEmpty | No transactions exist |
| DashboardError | Error fetching data with message |

## Data Flow

```
User opens Dashboard
       ↓
DashboardCubit loads data
       ↓
Repository fetches transactions from Supabase
       ↓
Calculate: income sum, expense sum, balance
       ↓
Emit appropriate state
```

## Relationships

- **Dashboard** aggregates from **Transaction** (existing entity from Phase 4)
- Dashboard queries transactions filtered by:
  - user_id (authenticated user)
  - date within current period (month)
  - type (income/expense)

## Validation Rules

1. Balance calculation: income - expenses (can be negative)
2. All monetary values should handle decimal precision (2 decimal places)
3. Empty state when no transactions match criteria
4. Error state on database/network failures

## State Transitions

```
Initial → Loading → Loaded (with data)
               → Empty (no transactions)
               → Error (failure)
```
