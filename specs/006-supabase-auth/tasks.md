# Tasks: Supabase Authentication

**Feature**: Phase 3 - Authentication (Supabase)  
**Branch**: 006-supabase-auth  
**Generated**: 2026-04-04

## Implementation Strategy

**MVP Scope**: User Story 1 (Sign Up) + User Story 2 (Log In) - Core auth functionality  
**Delivery Approach**: Incremental - implement foundational setup first, then each user story independently

---

## Phase 1: Setup

*Project initialization and dependency setup*

- [x] T001 Create Supabase client service in lib/core/services/supabase_service.dart
- [x] T002 Initialize Supabase in main.dart with URL and anonKey
- [x] T003 Configure dependency injection for auth services in lib/core/di/

---

## Phase 2: Foundational

*Blocking prerequisites - MUST complete before user stories*

- [x] T004 [P] Create auth feature directory structure
- [x] T005 [P] Create auth domain entities (User entity)
- [x] T006 [P] Create auth repository interface in lib/features/auth/domain/repositories/auth_repository.dart
- [x] T007 Create AuthCubit base class in lib/features/auth/presentation/cubit/auth_cubit.dart
- [x] T008 Setup go_router with auth redirect guard in lib/core/router/

---

## Phase 3: User Story 1 - Sign Up for New Account (P1)

*Goal*: Users can create a new account with email and password  
*Independent Test*: Enter valid credentials, submit form, verify user is redirected to dashboard with active session

- [x] T009 [P] [US1] Create SignupPage UI in lib/features/auth/presentation/pages/signup_page.dart
- [x] T010 [P] [US1] Create email input widget in lib/features/auth/presentation/widgets/email_input.dart
- [x] T011 [P] [US1] Create password input widget with validation in lib/features/auth/presentation/widgets/password_input.dart
- [x] T012 [US1] Implement signUp method in AuthCubit using Supabase
- [x] T013 [US1] Add email format validation (FR-002)
- [x] T014 [US1] Add password strength validation - minimum 8 characters (FR-003)
- [x] T015 [US1] Handle signup errors - email already registered (FR-009)
- [x] T016 [US1] Navigate to dashboard on successful signup

---

## Phase 4: User Story 2 - Log In to Existing Account (P1)

*Goal*: Users can log into their existing account  
*Independent Test*: Enter valid credentials, verify access to main app with restored session data

- [x] T017 [P] [US2] Create LoginPage UI in lib/features/auth/presentation/pages/login_page.dart
- [x] T018 [P] [US2] Create auth form widget in lib/features/auth/presentation/widgets/auth_form.dart
- [x] T019 [US2] Implement signIn method in AuthCubit using Supabase
- [x] T020 [US2] Handle login errors - invalid credentials (FR-009)
- [x] T021 [US2] Navigate to dashboard on successful login
- [x] T022 [US2] Add "Forgot Password" link to login page

---

## Phase 5: User Story 3 - Secure Password Recovery (P2)

*Goal*: Users can reset forgotten password  
*Independent Test*: Request password reset email, follow reset link, create new password

- [x] T023 [P] [US3] Create ForgotPasswordPage UI in lib/features/auth/presentation/pages/forgot_password_page.dart
- [x] T024 [US3] Implement resetPassword method in AuthCubit using Supabase
- [x] T025 [US3] Show success message after reset email requested (security - don't reveal if email exists)
- [x] T026 [US3] Handle password reset confirmation flow

---

## Phase 6: User Story 4 - Log Out Securely (P2)

*Goal*: Users can log out to protect their data on shared devices  
*Independent Test*: Log out, verify app redirects to login and clears session data

- [x] T027 [P] [US4] Implement signOut method in AuthCubit
- [x] T028 [US4] Add logout option to app settings or profile menu
- [x] T029 [US4] Clear session and redirect to login on logout
- [x] T030 [US4] Prevent back navigation to authenticated screens after logout

---

## Phase 7: User Story 5 - Session Persistence (P1)

*Goal*: Users don't have to log in every time they open the app  
*Independent Test*: Close and reopen app without logging out, verify user remains authenticated

- [x] T031 [P] [US5] Implement session check on app start in AuthCubit
- [x] T032 [US5] Auto-login user with valid existing session (FR-006)
- [x] T033 [US5] Handle session expiration and redirect to login (FR-011)
- [x] T034 [US5] Persist session tokens securely using supabase_flutter built-in

---

## Phase 8: Polish & Cross-Cutting Concerns

*Final verification and cleanup*

- [x] T035 [P] Create auth state UI components (loading spinner, error display)
- [x] T036 [P] Add loading states during auth operations
- [x] T037 Add empty state handling for auth forms
- [x] T038 Verify all navigation routes work correctly
- [x] T039 Test all user stories independently
- [x] T040 Create migration file supabase/migrations/001_auth_setup.sql

---

## Dependency Graph

```
Phase 1 (Setup)
  └─ Phase 2 (Foundational)
       ├─ Phase 3 (US1 - Sign Up)
       ├─ Phase 4 (US2 - Log In)
       ├─ Phase 5 (US3 - Password Recovery)
       ├─ Phase 6 (US4 - Log Out)
       └─ Phase 7 (US5 - Session Persistence)

User Stories can be implemented in parallel after Phase 2:
- US1, US2, US3, US4, US5 can run in parallel (independent)
```

## Parallel Opportunities

| Stories | Reason |
|---------|--------|
| US1 + US2 | Both use AuthCubit signIn/signUp methods, different UI pages |
| US3 + US4 | Both call auth methods, independent flows |
| US1 + US2 + US3 + US4 + US5 | All share AuthCubit - implement cubit first, then pages in parallel |

---

## Task Summary

| Phase | Description | Tasks |
|-------|-------------|-------|
| Phase 1 | Setup | T001-T003 |
| Phase 2 | Foundational | T004-T008 |
| Phase 3 | US1 - Sign Up | T009-T016 |
| Phase 4 | US2 - Log In | T017-T022 |
| Phase 5 | US3 - Password Recovery | T023-T026 |
| Phase 6 | US4 - Log Out | T027-T030 |
| Phase 7 | US5 - Session Persistence | T031-T034 |
| Phase 8 | Polish | T035-T040 |

**Total Tasks**: 40

**Suggested MVP Scope**: Phase 1 + Phase 2 + Phase 3 (Sign Up) + Phase 4 (Log In) - T001-T022

This provides core authentication functionality (signup and login) as the minimum viable product for this phase.
