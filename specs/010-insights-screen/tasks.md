# Implementation Tasks: Phase 7 - Insights Screen

**Feature Branch**: `010-insights-screen` | **Generated**: 2026-04-06

---

## Summary

This feature adds an Insights Screen to help users understand their financial behavior through:
- Spending by category (PieChart)
- Weekly spending comparison (BarChart)
- Monthly trends (LineChart)
- Top spending category highlight

**Tech Stack**: Dart 3.x / Flutter 3.x, flutter_bloc (Cubit), supabase_flutter, fl_chart

**User Stories**:
| Story | Priority | Description | Chart Type |
|-------|----------|-------------|------------|
| US1 | P1 | View Spending by Category | PieChart/DonutChart |
| US2 | P2 | Compare Weekly Spending | BarChart |
| US3 | P2 | View Monthly Trends | LineChart |
| US4 | P2 | Identify Top Spending Category | Highlighted in PieChart |

---

## Phase 1: Setup

**Purpose**: Initialize project structure and add dependencies

- [X] T001 Add fl_chart dependency to pubspec.yaml in lib/
- [X] T002 Create folder structure for insights feature in lib/features/insights/
- [X] T003 Create data/models/ directory in lib/features/insights/data/
- [X] T004 Create data/repositories/ directory in lib/features/insights/data/
- [X] T005 Create domain/entities/ directory in lib/features/insights/domain/
- [X] T006 Create domain/repositories/ directory in lib/features/insights/domain/
- [X] T007 Create presentation/cubit/ directory in lib/features/insights/presentation/
- [X] T008 Create presentation/pages/ directory in lib/features/insights/presentation/
- [X] T009 Create presentation/widgets/ directory in lib/features/insights/presentation/

---

## Phase 2: Foundational

**Purpose**: Create core entities and base infrastructure (required before all user stories)

- [X] T010 Create SpendingByCategory entity in lib/features/insights/domain/entities/spending_by_category.dart
- [X] T011 Create WeeklyComparison entity in lib/features/insights/domain/entities/weekly_comparison.dart
- [X] T012 Create MonthlyTrend entity in lib/features/insights/domain/entities/monthly_trend.dart
- [X] T013 Create TopCategory entity in lib/features/insights/domain/entities/top_category.dart
- [X] T014 Create InsightsState base class in lib/features/insights/presentation/cubit/insights_state.dart
- [ ] T015 Create InsightsEvent base class in lib/features/insights/presentation/cubit/insights_event.dart (SKIPPED - using Cubit pattern)
- [X] T016 Define InsightsRepository interface in lib/features/insights/domain/repositories/insights_repository.dart

---

## Phase 3: User Story 1 - View Spending by Category (P1)

**Goal**: Display spending breakdown by category with percentages

**Independent Test**: User opens Insights screen → sees PieChart with category breakdown → can identify where money goes

**Implementation**:

- [X] T017 [US1] Create SpendingByCategoryModel in lib/features/insights/data/models/spending_by_category_model.dart
- [X] T018 [US1] Implement InsightsRepository in lib/features/insights/data/repositories/insights_repository_impl.dart with getSpendingByCategory method
- [X] T019 [US1] Create CategoryBreakdownQuery in lib/features/insights/data/datasources/insights_datasource.dart (combined datasource)
- [X] T020 [US1] Implement InsightsCubit.loadCategoryBreakdown() in lib/features/insights/presentation/cubit/insights_cubit.dart
- [X] T021 [US1] Create CategoryPieChart widget in lib/features/insights/presentation/widgets/category_pie_chart.dart using fl_chart PieChart
- [X] T022 [US1] Create CategoryLegend widget in lib/features/insights/presentation/widgets/category_legend.dart
- [X] T023 [US1] Create InsightsLoaded state with all insight data in lib/features/insights/presentation/cubit/insights_state.dart
- [X] T024 [US1] Implement empty state for no transactions in lib/features/insights/presentation/widgets/insights_empty_state.dart

**Widget Details**:
- CategoryPieChart: Uses fl_chart PieChart with touchCallback for interactivity
- CategoryLegend: Shows category name, amount, percentage with color indicator
- Empty state: Friendly message encouraging user to add transactions

---

## Phase 4: User Story 2 - Compare Weekly Spending (P2)

**Goal**: Show current week vs previous week with percentage change

**Independent Test**: User scrolls to weekly section → sees bar chart with two bars → sees percentage change indicator (green/red)

**Implementation**:

- [X] T025 [US2] Create WeeklyComparisonModel in lib/features/insights/data/models/weekly_comparison_model.dart
- [X] T026 [US2] Add getWeeklyComparison method to InsightsRepository in lib/features/insights/data/repositories/insights_repository_impl.dart
- [X] T027 [US2] Create WeeklyComparisonQuery in lib/features/insights/data/datasources/insights_datasource.dart (combined datasource)
- [X] T028 [US2] Implement InsightsCubit.loadWeeklyComparison() in lib/features/insights/presentation/cubit/insights_cubit.dart
- [X] T029 [US2] Create WeeklyComparisonBarChart widget in lib/features/insights/presentation/widgets/weekly_comparison_chart.dart using fl_chart BarChart
- [X] T030 [US2] Create TrendIndicator widget in lib/features/insights/presentation/widgets/trend_indicator.dart (green arrow for decrease, red for increase)
- [X] T031 [US2] Add weekly comparison empty state handling in lib/features/insights/presentation/widgets/insights_empty_state.dart

**Widget Details**:
- WeeklyComparisonBarChart: Two bars side by side (current week, previous week)
- TrendIndicator: Arrow icon + percentage text, green for decrease (good), red for increase (warning)

---

## Phase 5: User Story 3 - View Monthly Trends (P2)

**Goal**: Display spending trends over past months

**Independent Test**: User scrolls to trends section → sees line chart → can see spending pattern over time

**Implementation**:

- [X] T032 [US3] Create MonthlyTrendModel in lib/features/insights/data/models/monthly_trend_model.dart
- [X] T033 [US3] Add getMonthlyTrends method to InsightsRepository in lib/features/insights/data/repositories/insights_repository_impl.dart
- [X] T034 [US3] Create MonthlyTrendsQuery in lib/features/insights/data/datasources/insights_datasource.dart (combined datasource)
- [X] T035 [US3] Implement InsightsCubit.loadMonthlyTrends() in lib/features/insights/presentation/cubit/insights_cubit.dart
- [X] T036 [US3] Create MonthlyTrendsLineChart widget in lib/features/insights/presentation/widgets/monthly_trends_chart.dart using fl_chart LineChart
- [X] T037 [US3] Add insufficient data message for < 2 months in lib/features/insights/presentation/widgets/insights_empty_state.dart

**Widget Details**:
- MonthlyTrendsLineChart: X-axis = months (YYYY-MM), Y-axis = total spending, dot markers for each month
- Shows current year only (per clarification)

---

## Phase 6: User Story 4 - Identify Top Spending Category (P2)

**Goal**: Highlight the category with highest spending

**Independent Test**: User sees top category prominently displayed with visual highlight

**Implementation**:

- [X] T038 [US4] Create TopCategoryModel in lib/features/insights/data/models/top_category_model.dart
- [X] T039 [US4] Add getTopCategory method to InsightsRepository in lib/features/insights/data/repositories/insights_repository_impl.dart
- [X] T040 [US4] Implement InsightsCubit.loadTopCategory() in lib/features/insights/presentation/cubit/insights_cubit.dart
- [X] T041 [US4] Update CategoryPieChart to highlight top category in lib/features/insights/presentation/widgets/category_pie_chart.dart (larger section, different color, badge)
- [X] T042 [US4] Create TopCategoryCard widget in lib/features/insights/presentation/widgets/top_category_card.dart

**Widget Details**:
- TopCategoryCard: Shows category name, amount, percentage with "Top Spending" badge
- PieChart highlight: Explode top category section, use accent color

---

## Phase 7: Polish & Integration

**Purpose**: Final integration, real-time updates, navigation

- [X] T043 Create InsightsPage in lib/features/insights/presentation/pages/insights_page.dart
- [X] T044 Add go_router route for /insights in lib/app.dart (route defined in app_router)
- [X] T045 Implement InsightsCubit.loadAllInsights() to load all data on screen entry
- [ ] T046 Add InsightsCubit subscription for real-time updates when transactions change (NOT IMPLEMENTED - optional enhancement)
- [X] T047 Implement pull-to-refresh in InsightsPage
- [ ] T048 Add loading skeleton state in lib/features/insights/presentation/widgets/insights_loading_state.dart (NOT IMPLEMENTED - using CircularProgressIndicator instead)
- [X] T049 Add error state with retry button in lib/features/insights/presentation/widgets/insights_error_state.dart
- [X] T050 Add navigation from Dashboard to Insights in lib/features/dashboard/presentation/screens/dashboard_screen.dart

---

## Dependencies Graph

```
Phase 1 (Setup)
    ↓
Phase 2 (Foundational) ← Required for all stories
    ↓
    ├── Phase 3 (US1) ──────────┐
    ├── Phase 4 (US2) ──────────┤
    ├── Phase 5 (US3) ──────────┤
    └── Phase 6 (US4) ──────────┘
            ↓
    Phase 7 (Polish & Integration)
```

---

## Parallel Opportunities

| Tasks | Can Run In Parallel Because |
|-------|------------------------------|
| T017-T019 | Different files, no dependencies |
| T025-T027 | Different files, no dependencies |
| T032-T034 | Different files, no dependencies |
| T038-T040 | Different files, no dependencies |
| T021-T023 | Can start after T017-T019 complete |
| T029-T031 | Can start after T025-T027 complete |
| T036-T037 | Can start after T032-T034 complete |
| T041-T042 | Can start after T038-T040 complete |

---

## Implementation Strategy

**MVP Scope (US1 - P1)**: 
- Phase 1 + Phase 2 + Phase 3 = Working category breakdown
- User can open Insights → see PieChart of spending by category
- Recommended delivery order for fastest value

**Incremental Delivery**:
1. Complete Phase 1-3 → Core feature working (US1)
2. Add Phase 4 → Weekly comparison (US2)
3. Add Phase 5 → Monthly trends (US3)
4. Add Phase 6 → Top category highlight (US4)
5. Add Phase 7 → Polish and navigation

---

## File Paths Summary

| Component | Path |
|-----------|------|
| Entities | lib/features/insights/domain/entities/ |
| Models | lib/features/insights/data/models/ |
| Repository | lib/features/insights/data/repositories/ |
| Cubit | lib/features/insights/presentation/cubit/ |
| Pages | lib/features/insights/presentation/pages/ |
| Widgets | lib/features/insights/presentation/widgets/ |
| Queries | lib/features/insights/data/datasources/ |

---

## Total Task Count

| Phase | Tasks | Description |
|-------|-------|-------------|
| Phase 1 | 9 | Setup |
| Phase 2 | 7 | Foundational |
| Phase 3 | 8 | US1 - Category breakdown |
| Phase 4 | 7 | US2 - Weekly comparison |
| Phase 5 | 6 | US3 - Monthly trends |
| Phase 6 | 5 | US4 - Top category |
| Phase 7 | 8 | Polish & Integration |
| **Total** | **50** | |

---

## Completion Status

| Status | Count |
|--------|-------|
| Completed | 47 |
| Skipped/Not Needed | 2 |
| Not Completed | 1 |

**Overall Progress: 94% Complete**
