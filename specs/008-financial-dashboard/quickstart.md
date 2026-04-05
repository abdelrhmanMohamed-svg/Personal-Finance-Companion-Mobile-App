# Quickstart: Financial Dashboard Implementation

**Feature**: 008-financial-dashboard  
**Date**: 2026-04-05

## Prerequisites

Before implementing the Dashboard feature, ensure:

1. ✅ Phase 1 (Project Setup) is complete
2. ✅ Phase 3 (Authentication) is implemented - users can log in
3. ✅ Phase 4 (Transactions) is implemented - transactions can be created/retrieved

## Implementation Order

### Step 1: Create Dashboard Feature Structure

```bash
lib/features/dashboard/
├── data/
│   ├── models/
│   ├── repositories/
│   └── datasources/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── cubit/
    ├── screens/
    └── widgets/
```

### Step 2: Implement Data Layer

1. **DashboardSummary Model** - Data class for aggregated values
2. **DashboardRepository** - Fetch and aggregate transaction data
3. **Supabase Data Source** - Query transactions by user and period

### Step 3: Implement Domain Layer

1. **DashboardEntity** - Business entity
2. **GetDashboardSummary UseCase** - Business logic for aggregation

### Step 4: Implement Presentation Layer

1. **DashboardCubit** - State management (Initial, Loading, Loaded, Empty, Error)
2. **DashboardScreen** - Main UI
3. **SummaryCard Widget** - Reusable card component
4. **EmptyState Widget** - Friendly empty message
5. **ErrorWidget** - Error with retry option

### Step 5: Integration

1. Add route to DashboardScreen in go_router
2. Set Dashboard as home route after login
3. Add navigation to Insights

## Key Files to Create

| Layer | Files |
|-------|-------|
| Data | `dashboard_summary.dart`, `dashboard_repository.dart`, `dashboard_datasource.dart` |
| Domain | `dashboard_entity.dart`, `get_dashboard_summary.dart` |
| Presentation | `dashboard_cubit.dart`, `dashboard_screen.dart`, `summary_card.dart` |

## Testing Checklist

- [ ] Unit tests for DashboardSummary calculation
- [ ] Unit tests for DashboardRepository
- [ ] Widget tests for DashboardScreen
- [ ] Integration test for full dashboard flow

## Common Issues

| Issue | Solution |
|-------|----------|
| No transactions showing | Check user_id filter in query |
| Balance incorrect | Verify income/expense type filtering |
| Slow load | Add caching or optimize query |
