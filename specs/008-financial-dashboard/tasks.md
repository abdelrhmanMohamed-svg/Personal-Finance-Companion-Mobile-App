# Tasks: Financial Dashboard

**Input**: Design documents from `/specs/008-financial-dashboard/`
**Prerequisites**: plan.md, spec.md, data-model.md, quickstart.md

**Tests**: Not requested - implementation-only

**Organization**: Tasks grouped by user story to enable independent implementation and testing

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story (US1, US2, US3)
- **Paths**: Based on Flutter project structure (`lib/features/dashboard/`)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Verify project structure and prepare for Dashboard implementation

- [x] T001 Create Dashboard feature folder structure in `lib/features/dashboard/` with data/, domain/, presentation/ subdirectories
- [x] T002 [P] Create empty barrel files (export files) for each layer: `data/models/models.dart`, `data/repositories/repositories.dart`, `data/datasources/datasources.dart`, `domain/entities/entities.dart`, `domain/repositories/repositories.dart`, `domain/usecases/usecases.dart`, `presentation/cubit/cubit.dart`, `presentation/screens/screens.dart`, `presentation/widgets/widgets.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure required before any user story can be implemented

**⚠️ CRITICAL**: These tasks must complete before starting user story implementation

- [x] T003 Verify Supabase client is configured in `lib/core/services/supabase_service.dart` - confirm it exposes `supabase` client instance
- [x] T004 Verify Transaction model exists in `lib/features/transactions/data/models/transaction_model.dart` with fields: id, amount, type, category, date, note, user_id
- [x] T005 Verify Transaction repository exists in `lib/features/transactions/data/repositories/transaction_repository.dart` with method to fetch all transactions for a user
- [x] T006 [P] Create DashboardSummary model in `lib/features/dashboard/data/models/dashboard_summary.dart` with fields: currentBalance (double), totalIncome (double), totalExpenses (double), periodStart (DateTime), periodEnd (DateTime)
- [x] T007 Create DashboardRepository interface in `lib/features/dashboard/domain/repositories/dashboard_repository.dart` defining method: `Future<DashboardSummary> getDashboardSummary(String userId)`

**Checkpoint**: Foundation ready - user story implementation can begin

---

## Phase 3: User Story 1 - View Financial Overview (Priority: P1) 🎯 MVP

**Goal**: Display current balance, total income, and total expenses on the dashboard

**Independent Test**: Open dashboard, verify balance (income - expenses), income total, and expense total are correctly calculated from transaction data

### Data Layer

- [x] T008 [P] [US1] Implement DashboardSummary model in `lib/features/dashboard/data/models/dashboard_summary.dart` - add constructor, toEntity() method, fromEntity() method
- [x] T009 [P] [US1] Implement DashboardDataSource in `lib/features/dashboard/data/datasources/dashboard_datasource.dart` - query Supabase for transactions filtered by user_id and current month, calculate income sum and expense sum
- [x] T010 [US1] Implement DashboardRepositoryImpl in `lib/features/dashboard/data/repositories/dashboard_repository_impl.dart` - implement getDashboardSummary using data source

### Domain Layer

- [x] T011 [P] [US1] Create DashboardEntity in `lib/features/dashboard/domain/entities/dashboard_entity.dart` - business entity with same fields as DashboardSummary
- [x] T012 [US1] Implement GetDashboardSummary use case in `lib/features/dashboard/domain/usecases/get_dashboard_summary.dart` - call repository and return entity

### Presentation Layer

- [x] T013 [P] [US1] Create DashboardState in `lib/features/dashboard/presentation/cubit/dashboard_state.dart` - define states: DashboardInitial, DashboardLoading, DashboardLoaded(DashboardEntity), DashboardEmpty, DashboardError(String message)
- [x] T014 [US1] Create DashboardEvent in `lib/features/dashboard/presentation/cubit/dashboard_event.dart` - define events: LoadDashboard, RefreshDashboard
- [x] T015 [US1] Implement DashboardCubit in `lib/features/dashboard/presentation/cubit/dashboard_cubit.dart` - extend Cubit<DashboardState>, handle LoadDashboard event by calling use case and emitting appropriate state
- [x] T016 [US1] Register DashboardCubit in dependency injection (check `lib/injection_container.dart` or similar) - add getIt.registerFactory<DashboardCubit>(() => DashboardCubit(getDashboardSummary: getIt()))

### UI Implementation

- [x] T017 [US1] Create BalanceCard widget in `lib/features/dashboard/presentation/widgets/balance_card.dart` - displays current balance with formatted currency
- [x] T018 [US1] Create IncomeExpenseRow widget in `lib/features/dashboard/presentation/widgets/income_expense_row.dart` - displays total income and total expenses side by side
- [x] T019 [US1] Implement DashboardScreen in `lib/features/dashboard/presentation/screens/dashboard_screen.dart` - use BlocBuilder<DashboardCubit, DashboardState>, show BalanceCard and IncomeExpenseRow when Loaded, show CircularProgressIndicator when Loading, show empty message when Empty, show error with retry button when Error

**Checkpoint**: User Story 1 complete - dashboard shows financial overview

---

## Phase 4: User Story 2 - Navigate to Insights (Priority: P2)

**Goal**: Allow users to navigate from dashboard to Insights screen

**Independent Test**: Tap "View Insights" button/link on dashboard, verify navigation to Insights screen

### Navigation

- [x] T020 [P] [US2] Verify Insights route exists in router configuration (check `lib/core/router/app_router.dart` or similar) - should have route like `/insights`
- [x] T021 [US2] Add Insights navigation button to DashboardScreen in `lib/features/dashboard/presentation/screens/dashboard_screen.dart` - add a button or tappable area that calls `context.push('/insights')` using go_router

### UI Enhancement

- [x] T022 [US2] Add "View Details" or "See All" link below the summary section in DashboardScreen - navigates to Insights screen

**Checkpoint**: User Story 2 complete - users can navigate to Insights

---

## Phase 5: User Story 3 - Quick Summary Cards (Priority: P3)

**Goal**: Display summary cards for key financial metrics (Balance, Income, Expenses)

**Independent Test**: Verify dashboard shows three cards: Balance, Income, Expenses - each with correct calculated values

### Widget Implementation

- [x] T023 [P] [US3] Create SummaryCard widget in `lib/features/dashboard/presentation/widgets/summary_card.dart` - reusable card with title (e.g., "Balance"), value, and optional icon/color indicator
- [x] T024 [P] [US3] Create BudgetIndicator widget in `lib/features/dashboard/presentation/widgets/budget_indicator.dart` - shows positive indicator (green) when under budget, warning (red) when over budget (requires budget data from Goals feature - use placeholder for now)
- [x] T025 [US3] Update DashboardScreen to use SummaryCard widgets in `lib/features/dashboard/presentation/screens/dashboard_screen.dart` - replace BalanceCard and IncomeExpenseRow with three SummaryCards: Balance (currentBalance), Income (totalIncome), Expenses (totalExpenses)

**Checkpoint**: User Story 3 complete - dashboard shows summary cards

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: UI states and improvements affecting multiple user stories

- [x] T026 [P] Create EmptyStateWidget in `lib/features/dashboard/presentation/widgets/empty_state_widget.dart` - friendly message "No transactions yet. Add your first transaction to get started!" with add transaction button
- [x] T027 [P] Create ErrorStateWidget in `lib/features/dashboard/presentation/widgets/error_state_widget.dart` - error message with "Retry" button that calls context.read<DashboardCubit>().add(RefreshDashboard())
- [x] T028 Update DashboardScreen to show EmptyStateWidget when state is DashboardEmpty in `lib/features/dashboard/presentation/screens/dashboard_screen.dart`
- [x] T029 Update DashboardScreen to show ErrorStateWidget when state is DashboardError in `lib/features/dashboard/presentation/screens/dashboard_screen.dart`
- [x] T030 Add auto-refresh on app resume - add AppLifecycleObserver or use didChangeAppLifecycleState in DashboardScreen to call cubit.add(RefreshDashboard()) when returning to screen

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can proceed in parallel (if staffed) or sequentially (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - MVP, no dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational - Can be parallel with US1 (different files)
- **User Story 3 (P3)**: Can start after Foundational - Can be parallel with US1 and US2

### Within Each User Story

- Models → Services/Repositories → Use Cases → Cubit → UI
- Complete each story before moving to next priority

---

## Parallel Opportunities

- T002: All barrel files can be created in parallel
- T006, T008, T009: Data layer tasks can run in parallel
- T011, T013, T014, T017, T018: Domain and presentation layer for US1 can run in parallel where no dependencies
- T020, T022: US2 navigation tasks can run in parallel
- T023, T024: US3 widget tasks can run in parallel
- T026, T027: Polish widgets can run in parallel

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test dashboard shows balance, income, expenses
5. MVP delivers basic financial overview

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy (MVP!)
3. Add User Story 2 → Test independently → Users can navigate to Insights
4. Add User Story 3 → Test independently → Summary cards display
5. Add Polish → All UI states handled

### File Path Reference

```
lib/features/dashboard/
├── data/
│   ├── models/
│   │   └── dashboard_summary.dart
│   ├── repositories/
│   │   └── dashboard_repository_impl.dart
│   └── datasources/
│       └── dashboard_datasource.dart
├── domain/
│   ├── entities/
│   │   └── dashboard_entity.dart
│   ├── repositories/
│   │   └── dashboard_repository.dart
│   └── usecases/
│       └── get_dashboard_summary.dart
└── presentation/
    ├── cubit/
    │   ├── dashboard_cubit.dart
    │   ├── dashboard_state.dart
    │   └── dashboard_event.dart
    ├── screens/
    │   └── dashboard_screen.dart
    └── widgets/
        ├── balance_card.dart
        ├── income_expense_row.dart
        ├── summary_card.dart
        ├── budget_indicator.dart
        ├── empty_state_widget.dart
        └── error_state_widget.dart
```

---

## Notes

- [P] tasks = different files, no dependencies - can execute in parallel
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Test on real device/emulator: verify calculations match actual transaction data