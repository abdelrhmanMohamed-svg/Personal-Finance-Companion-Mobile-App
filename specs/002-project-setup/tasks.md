---

description: "Task list for Phase 1: Project Setup and Architecture"
---

# Tasks: Phase 1: Project Setup and Architecture

**Input**: Design documents from `/specs/002-project-setup/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: Tests are not required for Phase 1 project setup - focus on functional implementation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Project Initialization)

**Purpose**: Create Flutter project with dependencies and folder structure

- [X] T001 Initialize Flutter project in repository root with `flutter create .`
- [X] T002 [P] Configure pubspec.yaml with core dependencies: flutter_bloc, supabase_flutter, go_router, get_it, equatable
- [X] T003 [P] Configure pubspec.yaml with dev dependencies: bloc_test, mocktail, flutter_lints
- [X] T004 Create folder structure: lib/core/, lib/features/, lib/shared/, lib/routes/
- [X] T005 [P] Create subfolders for each feature: lib/features/auth/, lib/features/transactions/, lib/features/dashboard/, lib/features/goals/, lib/features/insights/
- [X] T006 [P] Create data/domain/presentation structure for each feature folder

---

## Phase 2: Foundational (Core Infrastructure)

**Purpose**: Core services that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T007 Create main.dart entry point in lib/main.dart
- [X] T008 Create app.dart with MaterialApp configuration in lib/app.dart
- [X] T009 Create Supabase service in lib/core/services/supabase_service.dart
- [X] T010 [P] Create environment configuration in lib/core/config/environment.dart
- [X] T011 [P] Create dependency injection setup in lib/core/services/dependency_injection.dart
- [X] T012 Create app theme in lib/core/theme/app_theme.dart

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Project Foundation Ready (Priority: P1) 🎯 MVP

**Goal**: Developers can run `flutter pub get` and create a buildable project within 5 minutes

**Independent Test**: Run `flutter pub get` and `flutter build` - should complete without errors

### Implementation for User Story 1

- [X] T013 [P] [US1] Verify all dependencies resolve in pubspec.yaml
- [X] T014 [US1] Ensure project builds for iOS simulator: `flutter build ios --simulator --no-codesign`
- [X] T015 [US1] Ensure project builds for Android emulator: `flutter build apk --debug`
- [X] T016 [US1] Create placeholder screen to verify app launches in lib/app.dart

**Checkpoint**: At this point, User Story 1 should be fully functional - project builds and runs

---

## Phase 4: User Story 2 - State Management Ready (Priority: P1)

**Goal**: Cubit state management pattern established with one Cubit per feature

**Independent Test**: Create a sample Cubit and verify state changes propagate to UI

### Implementation for User Story 2

- [X] T017 [P] [US2] Create auth state classes in lib/features/auth/presentation/cubits/auth_state.dart
- [X] T018 [P] [US2] Create auth cubit in lib/features/auth/presentation/cubits/auth_cubit.dart
- [X] T019 [US2] Create app-wide Cubit wrapper pattern in lib/core/cubits/app_cubit_observer.dart
- [X] T020 [US2] Register auth cubit in dependency injection
- [X] T021 [US2] Integrate CubitProvider in app.dart

**Checkpoint**: At this point, User Story 2 should be fully functional - Cubit pattern works

---

## Phase 5: User Story 3 - Backend Connectivity Ready (Priority: P1)

**Goal**: Supabase integration configured with environment-specific settings

**Independent Test**: Configure test credentials and verify the app can connect to Supabase

### Implementation for User Story 3

- [X] T022 [P] [US3] Create .env file template with SUPABASE_URL and SUPABASE_ANON_KEY
- [X] T023 [P] [US3] Add .env to .gitignore
- [X] T024 [US3] Update Supabase service to load credentials from environment in lib/core/services/supabase_service.dart
- [X] T025 [US3] Add environment enum (dev/staging/prod) in lib/core/config/environment.dart
- [X] T026 [US3] Add debug mode flag for Supabase in lib/core/config/environment.dart

**Checkpoint**: At this point, User Story 3 should be fully functional - Supabase connects with env config

---

## Phase 6: User Story 4 - Navigation Ready (Priority: P2)

**Goal**: Routing system supporting named routes and deep linking

**Independent Test**: Navigate to different routes and verify correct screens appear

### Implementation for User Story 4

- [X] T027 [P] [US4] Create router configuration in lib/routes/app_router.dart
- [X] T028 [P] [US4] Define route names constants in lib/routes/route_names.dart
- [X] T029 [US4] Create placeholder screens for initial routes in lib/features/auth/presentation/screens/
- [X] T030 [US4] Integrate GoRouter in app.dart
- [X] T031 [US4] Add deep link handling configuration

**Checkpoint**: At this point, User Story 4 should be fully functional - routing works for multiple screens

---

## Phase 7: User Story 5 - Code Organization Clear (Priority: P2)

**Goal**: Clear folder structure conventions followed by all team members

**Independent Test**: Folder structure matches documented architecture pattern

### Implementation for User Story 5

- [X] T032 [P] [US5] Add lib/core/theme/ structure with app_colors.dart, app_typography.dart
- [X] T033 [P] [US5] Add lib/core/utils/ with date_utils.dart, currency_utils.dart
- [X] T034 [P] [US5] Add lib/core/constants/ with app_constants.dart
- [X] T035 [US5] Add lib/shared/widgets/ with placeholder_widget.dart
- [X] T036 [US5] Add lib/shared/models/ with placeholder model
- [X] T037 [US5] Create README.md documenting folder structure conventions

**Checkpoint**: At this point, all user stories should be independently functional

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Final verification and documentation

- [ ] T038 [P] Run `flutter analyze` and fix all warnings in lib/
- [ ] T039 [P] Run `flutter format` on all Dart files
- [ ] T040 Verify all success criteria from spec.md are met:
        - SC-001: flutter pub get completes in under 5 minutes
        - SC-002: New feature can follow established pattern
        - SC-003: Environment config switches without code changes
        - SC-004: Folder structure is self-documenting
        - SC-005: App launches to working shell
        - SC-006: Routing works for 3+ screens
        - SC-007: App shell loads in under 3 seconds
- [ ] T041 Update quickstart.md with any additional setup steps discovered

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-7)**: All depend on Foundational phase completion
  - User stories can proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2)
- **Polish (Final Phase)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 3 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 4 (P2)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 5 (P2)**: Can start after Foundational (Phase 2) - No dependencies on other stories

### Within Each User Story

- Core infrastructure before feature implementation
- Services before UI integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- Models within a story marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: Setup Phase

```bash
# Launch all parallel setup tasks:
Task: "Configure pubspec.yaml with core dependencies"
Task: "Configure pubspec.yaml with dev dependencies"
Task: "Create folder structure: lib/core/, lib/features/, lib/shared/"
Task: "Create data/domain/presentation subfolders"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently - project builds and runs

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Add User Story 4 → Test independently → Deploy/Demo
6. Add User Story 5 → Test independently → Deploy/Demo
7. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (Project Foundation)
   - Developer B: User Story 2 (State Management)
   - Developer C: User Story 3 (Backend Connectivity)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence