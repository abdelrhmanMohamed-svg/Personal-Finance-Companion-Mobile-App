# Quickstart: Phase 7 - Insights Screen

## Prerequisites

- Flutter 3.x with Dart 3.x
- Supabase project configured
- Existing Transaction feature implemented (Phase 4)

## New Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  fl_chart: ^0.68.0
```

## Implementation Order

1. **Domain Layer**
   - Create entity classes: SpendingByCategory, WeeklyComparison, MonthlyTrend, TopCategory
   - Define repository interfaces

2. **Data Layer**
   - Implement repository with Supabase queries
   - Create data models mapping to/from Supabase

3. **Presentation Layer**
   - Create InsightsCubit with states: Initial, Loading, Loaded, Error
   - Build InsightsPage with widgets
   - Add chart widgets using fl_chart

## Key Integration Points

| Component | Depends On |
|-----------|------------|
| InsightsCubit | TransactionRepository |
| CategoryBreakdownWidget | SpendingByCategory entity |
| WeeklyComparisonWidget | WeeklyComparison entity |
| MonthlyTrendWidget | List<MonthlyTrend> |
| TopCategoryWidget | TopCategory entity |

## Testing Strategy

- Unit tests: Cubit state transitions, entity calculations
- Widget tests: Chart rendering, empty states
- Integration tests: Full insights flow with mock data

## Performance Targets

| Metric | Target |
|--------|--------|
| Screen load | < 2 seconds |
| Empty state | < 1 second |
| Chart render | < 500ms |
