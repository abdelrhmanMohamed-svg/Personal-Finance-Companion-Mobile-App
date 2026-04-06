# Tasks: UX and Polish

**Feature**: Phase 8: UX and Polish  
**Branch**: `011-ux-polish`  
**Date**: 2026-04-06

## Implementation Strategy

MVP scope: User Story 1 (Loading States) + User Story 3 (Error Handling) - these provide the most critical user experience improvements. Other stories can be implemented incrementally.

## Phase 1: Setup

No setup tasks required - using existing Flutter project structure.

## Phase 2: Foundational (Blocking Prerequisites)

These tasks MUST complete before any user story implementation.

- [X] T001 Create shared widgets directory structure in lib/shared/widgets/
- [X] T002 Create animation utilities in lib/core/utils/animation_utils.dart
- [X] T003 Create error formatting utilities in lib/core/utils/error_utils.dart
- [ ] T004 Add loading states to base Cubit or create mixin in lib/core/

## Phase 3: User Story 1 - Loading States (Priority: P1)

**Story Goal**: Users see visual feedback when the app is loading data  
**Independent Test**: Loading indicator appears within 200ms of data-fetching action

- [X] T005 [US1] Create LoadingIndicatorWidget in lib/shared/widgets/loading_indicator_widget.dart
- [X] T006 [US1] Create ShimmerLoadingWidget for skeleton loading in lib/shared/widgets/shimmer_loading_widget.dart
- [X] T007 [US1] Integrate loading states into TransactionsCubit in lib/features/transactions/presentation/cubit/transactions_cubit.dart
- [X] T008 [US1] Integrate loading states into DashboardCubit in lib/features/dashboard/presentation/cubit/dashboard_cubit.dart
- [X] T009 [US1] Integrate loading states into GoalsCubit in lib/features/goals/presentation/cubit/goals_cubit.dart
- [X] T010 [US1] Integrate loading states into InsightsCubit in lib/features/insights/presentation/cubit/insights_cubit.dart
- [X] T011 [US1] Add loading widgets to TransactionsScreen in lib/features/transactions/presentation/pages/transactions_page.dart
- [X] T012 [US1] Add loading widgets to DashboardPage in lib/features/dashboard/presentation/pages/dashboard_page.dart
- [X] T013 [US1] Test loading indicators appear within 200ms

## Phase 4: User Story 2 - Empty States (Priority: P1)

**Story Goal**: New users see helpful guidance when screens are empty  
**Independent Test**: Empty state displays with appropriate message and CTA on fresh account

- [X] T014 [US2] Create EmptyStateWidget in lib/shared/widgets/empty_state_widget.dart
- [X] T015 [US2] Add empty state to TransactionsScreen in lib/features/transactions/presentation/pages/transactions_page.dart
- [X] T016 [US2] Add empty state to DashboardPage in lib/features/dashboard/presentation/pages/dashboard_page.dart
- [X] T017 [US2] Add empty state to GoalsScreen in lib/features/goals/presentation/pages/goals_page.dart
- [X] T018 [US2] Add empty state to InsightsScreen in lib/features/insights/presentation/pages/insights_page.dart
- [ ] T019 [US2] Test empty states display on fresh user accounts

## Phase 5: User Story 3 - Error Handling (Priority: P1)

**Story Goal**: Users see clear, actionable error messages when something goes wrong  
**Independent Test**: User-friendly errors appear with retry options

- [X] T020 [US3] Create ErrorStateWidget in lib/shared/widgets/error_state_widget.dart
- [X] T021 [US3] Create error snackbar helper in lib/shared/widgets/error_snackbar.dart
- [X] T022 [US3] Implement modern error display using SnackBar in lib/core/utils/error_utils.dart
- [X] T023 [US3] Add error handling to TransactionsCubit in lib/features/transactions/presentation/cubit/transactions_cubit.dart
- [X] T024 [US3] Add error handling to DashboardCubit in lib/features/dashboard/presentation/cubit/dashboard_cubit.dart
- [ ] T025 [US3] Add error display to common error scenarios (network offline, data fetch failed)
- [ ] T026 [US3] Test error messages are user-friendly with retry options

## Phase 6: User Story 4 - Smooth Navigation (Priority: P2)

**Story Goal**: Transitions between screens feel fluid and responsive  
**Independent Test**: Screen transitions complete in under 300ms

- [X] T027 [US4] Create custom page route transitions in lib/core/utils/page_transitions.dart
- [X] T028 [US4] Configure navigation transitions in router configuration
- [ ] T029 [US4] Preserve screen state during navigation (existing Cubit state)
- [ ] T030 [US4] Test navigation transitions feel smooth (<300ms)

## Phase 7: User Story 5 - Basic Animations (Priority: P3)

**Story Goal**: Subtle animations provide visual feedback without being distracting  
**Independent Test**: Button presses show feedback, list additions animate in

- [X] T031 [US5] Create animated press effect for buttons in lib/shared/widgets/animated_button.dart
- [X] T032 [US5] Create list item entry animation in lib/shared/widgets/animated_list_item.dart
- [ ] T033 [US5] Create celebration animation for milestones in lib/shared/widgets/celebration_animation.dart
- [X] T034 [US5] Implement Reduce Motion accessibility check in animation_utils.dart
- [X] T035 [US5] Apply animations to button components
- [ ] T036 [US5] Apply animations to transaction list additions
- [ ] T037 [US5] Test animations respect Reduce Motion setting

## Phase 8: Polish & Cross-Cutting Concerns

- [ ] T038 Verify all screens show appropriate loading states
- [ ] T039 Verify all empty states have CTAs
- [ ] T040 Verify error handling works across all features
- [ ] T041 Test navigation feels smooth throughout the app
- [ ] T042 Test animations are subtle and not distracting
- [ ] T043 Verify accessibility (Reduce Motion) works correctly

## Dependencies

```
T001 → (no deps)
T002 → T001
T003 → T001
T004 → T001
T005 → T001, T004
T006 → T001
T007 → T005
T008 → T005
T009 → T005
T010 → T005
T011 → T007
T012 → T008
T013 → T011, T012

T014 → T001
T015 → T014, T011
T016 → T014, T012
T017 → T014
T018 → T014
T019 → T015, T016, T017, T018

T020 → T001
T021 → T001, T020
T022 → T003, T021
T023 → T022, T007
T024 → T022, T008
T025 → T022
T026 → T023, T024, T025

T027 → T001, T002
T028 → T027
T029 → (no deps)
T030 → T028, T029

T031 → T001, T002
T032 → T001, T002, T034
T033 → T001, T002, T034
T034 → T002
T035 → T031
T036 → T032
T037 → T034, T035, T036

T038 → T013, T019
T039 → T019
T040 → T026
T041 → T030
T042 → T037
T043 → T034
```

## Parallel Opportunities

| Task ID | Can Run In Parallel With |
|---------|-------------------------|
| T005 | T006, T014, T020, T027, T031 |
| T007 | T008, T009, T010 |
| T011 | T012, T015, T016 |
| T023 | T024 |
| T035 | T036 |

## Task Summary

| Phase | User Story | Task Count |
|-------|------------|------------|
| Phase 2 | Foundational | 4 tasks |
| Phase 3 | US1 - Loading States | 9 tasks |
| Phase 4 | US2 - Empty States | 6 tasks |
| Phase 5 | US3 - Error Handling | 7 tasks |
| Phase 6 | US4 - Smooth Navigation | 4 tasks |
| Phase 7 | US5 - Basic Animations | 7 tasks |
| Phase 8 | Polish | 6 tasks |
| **Total** | | **43 tasks** |

## MVP Scope

If limited to essential only, complete:
- Phase 2 (T001-T004)
- Phase 3 (T005-T013) - Critical for UX
- Phase 5 (T020-T026) - Critical for error handling
- Total: 21 tasks for MVP
