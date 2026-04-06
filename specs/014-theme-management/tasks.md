# Tasks: Theme Management (Light & Dark Mode)

**Feature**: Theme Management  
**Branch**: `014-theme-management`  
**Generated**: 2026-04-06

## Phase 1: Setup

- [X] T001 Add hydrated_bloc dependency to pubspec.yaml

## Phase 2: Foundational

- [X] T002 [P] Create app_theme.dart with light theme configuration in lib/core/theme/
- [X] T003 [P] Create app_theme.dart with dark theme configuration in lib/core/theme/
- [X] T004 Create ThemeCubit class extending HydratedCubit in lib/features/settings/presentation/cubit/theme_cubit.dart

## Phase 3: User Story 1 - Theme Selection (Priority: P1)

**Goal**: Users can switch between light and dark themes  
**Independent Test**: Toggle theme and verify all screens display correct colors

- [X] T005 [US1] Implement toggleTheme() method in ThemeCubit to switch between light/dark
- [X] T006 [US1] Update MaterialApp with BlocProvider<ThemeCubit> in lib/main.dart
- [X] T007 [US1] Configure theme: and darkTheme: with AppTheme in MaterialApp
- [X] T008 [US1] Add theme toggle UI (Switch/ListTile) in Settings screen

## Phase 4: User Story 2 - Theme Preference Persistence (Priority: P1)

**Goal**: Theme preference persists across app restarts  
**Independent Test**: Select theme, close app, reopen - verify same theme applied

- [X] T009 [US2] Override fromJson/toJson methods in ThemeCubit for state serialization
- [X] T010 [US2] Initialize HydratedBloc.storage in main() before runApp
- [X] T011 [US2] Verify state restores automatically on app launch

## Phase 5: User Story 3 - Smooth Theme Transition (Priority: P2)

**Goal**: Theme changes animate smoothly  
**Independent Test**: Toggle theme and observe 0.3-0.5s smooth color transition

- [X] T012 [P] [US3] Add AnimatedTheme widget wrapping MaterialApp content
- [X] T013 [US3] Configure duration: 350ms (within 0.3-0.5s range) for AnimatedTheme

## Phase 6: User Story 4 - System Theme Detection (Priority: P3)

**Goal**: App optionally follows device system theme  
**Independent Test**: Enable system detection, change device theme, verify app updates

- [ ] T014 [US3] [P] Add MediaQuery.platformBrightnessOf context to ThemeBuilder
- [X] T015 [US4] Implement setSystemTheme(bool enabled) method in ThemeCubit
- [X] T016 [US4] Add system theme toggle UI in Settings screen

## Phase 7: Polish & Cross-Cutting Concerns

- [X] T017 Apply ThemeData to all screens - verify navigation, cards, dialogs, forms use theme colors
- [ ] T018 Add debounce logic to prevent rapid toggle thrashing
- [X] T019 Add error handling for corrupted storage (fall back to light theme)
- [ ] T020 Add unit tests for ThemeCubit state transitions

## Dependencies

```
Setup (T001)
  └─> Foundational (T002-T004)
        ├─> US1: Theme Selection (T005-T008)
        ├─> US2: Persistence (T009-T011) - parallel with US1
        ├─> US3: Smooth Transition (T012-T013) - depends on US1
        └─> US4: System Detection (T014-T016) - depends on US1
              └─> Polish (T017-T020)
```

## Parallel Execution

- T002, T003 can run in parallel (separate theme files)
- T009-T011 can run parallel with T005-T008 (different aspects of ThemeCubit)
- T012 can run parallel with T014 (independent features)

## Implementation Strategy

**MVP Scope (US1 + US2)**:
- T001-T008: Core theme switching with persistence
- This delivers basic light/dark toggle functionality

**Incremental Delivery**:
- Add smooth transitions (T012-T013) 
- Add system theme detection (T014-T016)
- Polish and testing (T017-T020)

## Summary

| Metric | Count |
|--------|-------|
| Total Tasks | 20 |
| Setup Phase | 1 |
| Foundational Phase | 3 |
| User Story 1 | 4 |
| User Story 2 | 3 |
| User Story 3 | 2 |
| User Story 4 | 3 |
| Polish Phase | 4 |
| Parallelizable | 5 |