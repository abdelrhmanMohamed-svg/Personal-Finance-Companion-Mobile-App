# Personal Finance Companion Constitution

## Core Principles

### I. Feature-First Architecture
The project MUST follow a hybrid Feature-based + Clean Architecture structure. Each feature contains isolated data/, domain/, and presentation/ layers. Features MUST be self-contained and independently testable. No feature should depend on internal implementation details of another feature. Core utilities in lib/core/ provide shared theme, utils, and services accessible across all features. This enables maintainability and testability as the app scales.

### II. Cubit State Management
Each feature MUST have exactly one Cubit managing its state. State management MUST separate UI from business logic. Cubits MUST expose clear states and events following BLoC pattern principles. No feature should access another feature's Cubit directly; communication happens through the domain layer or shared services.

### III. Supabase Integration
The app MUST use Supabase for both Authentication and Database operations. Auth state MUST persist across app restarts using secure session storage. All database operations MUST use the Supabase client with proper error handling and type safety. User data isolation MUST be enforced at the database level using Row Level Security (RLS) policies.

### IV. Test-Driven Quality
All critical features MUST have corresponding tests. Unit tests MUST cover business logic in domain layers. Widget tests MUST verify UI components render correctly. Integration tests MUST verify feature-level user flows. Tests SHOULD be written before or alongside implementation following TDD principles for new features.

### V. Phase-Gated Development
Development MUST proceed through defined phases in strict order. Each phase MUST complete with verified deliverables before the next begins. Uncompleted phases MUST NOT be bypassed. The phases are: Phase 0 (Product Definition), Phase 1 (Project Setup), Phase 2 (Design System), Phase 3 (Authentication), Phase 4 (Transactions), Phase 5 (Dashboard), Phase 6 (Goals), Phase 7 (Insights), Phase 8 (UX/Polish), Phase 9 (Documentation).

## Phase Definitions

### Phase 0: Product Definition
Objective: Define product scope and user experience before development begins. Deliverables: User flows, screen list, navigation structure, MVP scope definition. Spec content: User persona, core features, app goals, navigation map, success criteria. This phase MUST complete before any code is written.

### Phase 1: Project Setup and Architecture
Objective: Set up a clean and scalable project structure. Deliverables: Flutter project initialized, folder structure created, Cubit setup, Supabase integration configured, routing system implemented. Spec content: Architecture decisions, folder structure, state management approach, environment configuration, dependency setup.

### Phase 2: Design System and Core UI
Objective: Create reusable UI components and a consistent design system. Deliverables: App theme (colors, typography), reusable widgets (buttons, inputs, cards), layout structure. Spec content: Design tokens, component definitions, spacing system, responsive behavior rules.

### Phase 3: Authentication
Objective: Implement user authentication using Supabase. Deliverables: Signup screen, login screen, auth state handling, session persistence. Spec content: Auth flow, validation rules, error handling, Cubit states, Supabase auth integration.

### Phase 4: Transactions Module
Objective: Build the main transaction management system. Deliverables: Add transaction, edit transaction, delete transaction, transaction list view, filtering and search. Spec content: Transaction data model, CRUD operations, UI flows, Cubit states, Supabase database integration, edge cases (empty state, invalid input).

### Phase 5: Dashboard
Objective: Provide a clear overview of financial data. Deliverables: Current balance display, total income and expenses, visual charts (category or weekly), quick summary cards. Spec content: Dashboard layout, data aggregation logic, chart types, UI states (loading, empty, error).

### Phase 6: Goals Feature
Objective: Add engaging and meaningful product features (Budget Tracker + Saving Streak). Deliverables: Budget setup UI, budget tracking logic, streak tracking system, alerts or indicators. Spec content: Goal data model, budget rules, streak calculation logic, UI flows, Cubit states, integration with transactions.

### Phase 7: Insights Screen
Objective: Help users understand their financial behavior. Deliverables: Spending by category, weekly comparison, monthly trends, top spending category. Spec content: Analytics calculations, data visualization logic, UI layout for insights, performance considerations.

### Phase 8: UX and Polish
Objective: Improve the overall mobile experience. Deliverables: Loading states, empty states, error handling, smooth navigation, basic animations. Spec content: UX rules, interaction behavior, state handling patterns, accessibility considerations.

### Phase 9: Documentation and Final Review
Objective: Prepare the project for evaluation. Deliverables: README file, setup instructions, feature explanation, architecture explanation. Spec content: Project overview, installation steps, assumptions, known limitations.

## Technology Stack

The technology stack defines constraints that all implementation MUST follow:

**Frontend**: Flutter (Dart) with Material Design 3, Google Stitch generated UI components
**State Management**: Cubit from flutter_bloc package
**Backend**: Supabase (Auth + PostgreSQL Database)
**Architecture**: Feature-based + Clean Architecture hybrid

All new features MUST use the feature folder structure with data/domain/presentation layers. Shared code goes in lib/core/ or lib/shared/. No feature should contain code that belongs in another feature's domain layer.

## Data Models

The following data models MUST be implemented as specified:

**Transaction**: id, amount, type (income|expense), category, date, note, user_id
**Budget**: id, user_id, category (optional), limit_amount, current_spent, period (monthly)
**Streak**: id, user_id, current_streak, last_updated

## Development Workflow

All development MUST follow this workflow:

1. Create feature branch from main
2. Implement feature in isolation following data/domain/presentation layers
3. Write tests alongside implementation
4. Verify against feature specification
5. Submit pull request after code review

Code Review Requirements: All PRs require at least one reviewer. Architecture consistency check mandatory. Tests must pass before merge. Documentation updates required for user-facing changes.

## Success Criteria

The project is considered successful when all of the following are met:

- All core features are functional
- UI is clean and mobile-friendly
- State management is clear and organized
- Data handling is consistent
- Code is readable and maintainable
- The app feels like a real product, not a demo

## Governance

This constitution supersedes all other development practices. Any deviation requires documented justification and team approval.

**Amendment Procedure**: Propose change with rationale → Document impact on existing phases/features → Update version according to semantic versioning → Update LAST_AMENDED_DATE to current date → Notify team of changes.

**Versioning Policy**:
- MAJOR: Backward incompatible architectural changes or principle removals
- MINOR: New principles or phases added, materially expanded guidance
- PATCH: Clarifications, wording fixes, non-semantic refinements

**Compliance Review**: All new features must verify they align with core principles. Architecture decisions must reference this constitution. Use this document for runtime development guidance.

**Version**: 1.0.0 | **Ratified**: 2026-04-03 | **Last Amended**: 2026-04-03