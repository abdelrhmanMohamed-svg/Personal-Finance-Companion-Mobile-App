# Tasks: Phase 2.1 UI Implementation (Flutter)

**Feature Branch**: 005-flutter-ui-implementation  
**Date**: 2026-04-04

## Phase 1: Setup

- [X] T001 Initialize ScreenUtil in lib/main.dart
- [X] T002 Configure design draft size (375x812)

---

## Phase 2: Theme & Design Tokens

- [X] T003 [US1] Apply design tokens to ThemeData in lib/core/theme/app_theme.dart
- [X] T004 [US1] Set up color scheme (primary, secondary, background)
- [X] T005 [US1] Configure typography (headline, body, label sizes)

---

## Phase 3: Reusable Widgets

- [X] T006 [US2] Create AppButton component in lib/shared/widgets/app_button.dart
- [X] T007 [US2] Create AppInput component in lib/shared/widgets/app_input.dart
- [X] T008 [US2] Create AppCard component in lib/shared/widgets/app_card.dart
- [X] T009 [US2] Create AppText component in lib/shared/widgets/app_text.dart

---

## Phase 4: Responsive UI

- [X] T010 [US3] Configure ScreenUtil for responsive scaling
- [X] T011 [US3] Apply responsive sizing to all widgets

---

## Phase 5: Build Screens

### Dashboard
- [X] T012 [US4] Build Dashboard screen in lib/features/dashboard/presentation/screens/dashboard_screen.dart
- [X] T013 [US4] Add BalanceCard widget
- [X] T014 [US4] Add IncomeExpenseCard widget

### Transactions
- [X] T015 [US4] Build TransactionsList screen in lib/features/transactions/presentation/screens/transactions_list_screen.dart
- [X] T016 [US4] Build AddEditTransaction screen in lib/features/transactions/presentation/screens/add_edit_transaction_screen.dart

### Goals
- [X] T017 [US4] Build Goals screen in lib/features/goals/presentation/screens/goals_screen.dart

### Insights
- [X] T018 [US4] Build Insights screen in lib/features/insights/presentation/screens/insights_screen.dart

---

## Phase 6: Organization

- [X] T019 [US5] Ensure feature folder structure follows data/domain/presentation pattern

---

## Dependencies

```
T001 ─┬─ T003 ─┬─ T012 ─ T019
T002 ─┘       ├─ T015 ─ T016 ─ T019
             ├─ T017 ─ T019
             └─ T018 ─ T019

All T003-T009 must complete before T012-T018
```

## Independent Test Criteria

| User Story | Test |
|------------|------|
| US1 (Theme) | Verify all widgets use design tokens without manual styling |
| US2 (Widgets) | Use only reusable widgets, verify visual consistency |
| US3 (Responsive) | Test on 320px-414px screen widths |
| US4 (Screens) | Navigate all 5 screens, verify they use component library |
| US5 (Organization) | Each feature has its own presentation layer |

## MVP Scope

Start with: T001-T009 (Setup + Theme + Widgets)  
Then: T012-T014 (Dashboard screen first)  
Complete: All tasks

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 19 |
| User Stories | 5 |
| Parallel Opportunities | 2 (T003-T005, T006-T009, T012-T018) |
