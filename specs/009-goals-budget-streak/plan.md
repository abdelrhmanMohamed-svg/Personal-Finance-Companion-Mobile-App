# Implementation Plan: Goals Feature (Budget Tracker + Savings Goals + Saving Streak)

**Branch**: `009-goals-budget-streak` | **Date**: 2026-04-05 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/009-goals-budget-streak/spec.md`

## Summary

This feature implements Phase 6 of the Personal Finance Companion app - Goals Feature with Budget Tracker, Savings Goals, and Saving Streak. Users can set monthly budgets (both total and category-specific), create open-ended savings goals, and track consecutive days of staying within budget. The feature integrates with the existing transaction system from Phase 4.

## Technical Context

**Language/Version**: Dart 3.x, Flutter 3.x  
**Primary Dependencies**: flutter_bloc (Cubit), supabase_flutter, go_router, get_it, equatable, screen_util_flutter, google_fonts  
**Storage**: Supabase (PostgreSQL)  
**Testing**: Flutter test (unit, widget tests)  
**Target Platform**: Mobile (iOS/Android)  
**Project Type**: Mobile app  
**Performance Goals**: Smooth 60fps UI, immediate feedback on transactions  
**Constraints**: Offline-capable with Supabase offline support  
**Scale/Scope**: Single user, moderate transaction volume (100s-1000s of transactions)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Gate | Status | Notes |
|------|--------|-------|
| Feature-first Architecture | PASS | Goals feature will follow data/domain/presentation layers |
| Cubit State Management | PASS | Single GoalsCubit managing state |
| Supabase Integration | PASS | Uses existing Supabase client for budgets, goals, streaks |
| Test-Driven Quality | PASS | Unit tests for domain logic, widget tests for UI |
| Phase-Gated Development | PASS | Phase 6 feature, preceding phases completed |

## Project Structure

### Documentation (this feature)

```text
specs/009-goals-budget-streak/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (if needed)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── theme/
│   ├── utils/
│   └── services/
├── features/
│   ├── auth/           # Phase 3 - completed
│   ├── transactions/   # Phase 4 - completed
│   ├── dashboard/      # Phase 5 - completed
│   ├── goals/          # Phase 6 - THIS FEATURE
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── pages/
│   │       └── widgets/
│   └── insights/       # Phase 7 - future
└── shared/
    ├── widgets/
    └── models/

test/
├── unit/
├── widget/
└── integration/
```

**Structure Decision**: Feature-based architecture following the existing pattern. Goals feature will have its own data/domain/presentation layers, reusing shared services from core/.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations. Constitution gates all pass.

## Phase 0: Research

> Objective: Resolve unknowns and gather implementation knowledge

### Research Tasks

Based on the feature specification, the following areas need research:

| Task | Description | Status |
|------|-------------|--------|
| 1 | Supabase database schema for Budget, SavingsGoal, Streak entities | Required |
| 2 | Best practices for streak calculation in mobile apps | Required |
| 3 | Flutter UI patterns for budget progress visualization | Required |
| 4 | Integration with existing transaction data model | Required |

### Research Findings

#### 1. Supabase Database Schema

The constitution specifies existing data models:
- **Budget**: id, user_id, category (optional), limit_amount, current_spent, period (monthly)
- **Streak**: id, user_id, current_streak, last_updated

Additional model needed for Phase 6:
- **SavingsGoal**: id, user_id, target_amount, current_saved, name/description, created_at

**Database design approach**: Use Supabase PostgreSQL with RLS policies for user data isolation. Tables follow the existing pattern from Transaction model.

#### 2. Streak Calculation Best Practices

- Track daily budget compliance by checking if cumulative spending at end of day <= budget limit
- Update streak incrementally: if day passes without exceeding budget, increment
- Reset immediately on overspend (no grace period, per spec clarification)
- Store last_updated to track streak continuity across app sessions

#### 3. Flutter UI Patterns for Budget Progress

- Use LinearProgressIndicator or custom progress bar for budget visualization
- Color coding: green (safe), yellow (warning 80%), red (exceeded)
- Display percentage and remaining amount text alongside visual indicator

#### 4. Integration with Transaction Data

- Query transactions filtered by user_id, date range, and optionally category
- Calculate spending for budgets by summing expense transactions
- Calculate saved amount for goals by summing income transactions
- Real-time updates via Supabase realtime subscriptions or manual refresh
