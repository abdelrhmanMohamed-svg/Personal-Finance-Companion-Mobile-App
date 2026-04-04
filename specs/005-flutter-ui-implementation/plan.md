# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement UI components and screens for Phase 2.1 using design tokens from Google Stitch. Create a unified theme, reusable widget library (buttons, inputs, cards), responsive layouts, and all 5 core screens (dashboard, transactions, add/edit, goals, insights).

## Technical Context

**Language/Version**: Dart 3.x (Flutter 3.x)  
**Primary Dependencies**: flutter_bloc (Cubit), screen_util_flutter, google_fonts, supabase_flutter  
**Storage**: N/A (UI-only phase - no persistent data)  
**Testing**: Flutter test framework (widget tests)  
**Target Platform**: Mobile (iOS 12+, Android API 21+)  
**Project Type**: mobile-app  
**Performance Goals**: N/A (deferred to Phase 8)  
**Constraints**: Mobile only (320px-414px width), no tablets or desktops, light mode only for MVP  
**Scale/Scope**: 5 screens, 3+ reusable components, feature-based folder structure

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Feature-First Architecture | ✓ PASS | UI code organized by feature with separate presentation layers |
| II. Cubit State Management | ✓ PASS | Each feature will have its Cubit (Phase 3+) |
| III. Supabase Integration | N/A | Not in scope for Phase 2.1 (Phase 3) |
| IV. Test-Driven Quality | ✓ PASS | Widget tests should verify UI components |
| V. Phase-Gated Development | ✓ PASS | Phase 2.1 follows Phase 2.0 completion - verified |

**Phase Verification**: Phase 2.1 (UI Implementation) requires Phase 2.0 (Design System) to be complete - confirmed via design tokens availability.

### Post-Phase 1 Re-evaluation

All gates pass. Research completed:
- Design token source: Google Stitch MCP + local fallback
- Responsive approach: ScreenUtil (already in dependencies)
- Performance: Deferred to Phase 8

## Project Structure

### Documentation (this feature)

```text
specs/005-flutter-ui-implementation/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── theme/           # Design tokens applied to theme
│   ├── utils/
│   └── services/
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       └── screens/
│   ├── transactions/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   ├── dashboard/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   ├── goals/
│   │   └── presentation/
│   │       └── screens/
│   └── insights/
│       └── presentation/
│           └── screens/
└── shared/
    ├── widgets/         # Reusable UI components (buttons, inputs, cards)
    └── models/

test/
├── widget/              # Widget tests for UI components
└── integration/         # Integration tests for screens
```

**Structure Decision**: Flutter mobile app with feature-based architecture. Shared widgets in `lib/shared/widgets/` for reuse across features. Each feature contains its own `presentation/screens/` and `presentation/widgets/` subdirectories.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| N/A | No violations | - |

---

# Phase 0: Outline & Research

## Research Tasks

The following unknowns were identified in Technical Context:

### Task 1: Google Stitch MCP Integration
- **Research**: How to obtain design tokens from Google Stitch MCP
- **Status**: REQUIRED - Clarified via user input: Primary source via MCP, fallback to local `design/` folder

### Task 2: Design Token Conversion
- **Research**: How to convert Google Stitch design tokens to Flutter ThemeData
- **Status**: REQUIRED - Design tokens may come in any format, need conversion logic

### Task 3: Responsive UI Best Practices
- **Research**: Flutter responsive design patterns (ScreenUtil vs MediaQuery vs LayoutBuilder)
- **Status**: REQUIRED - Need to choose the best approach for mobile-only app

---

# Phase 1: Design & Contracts

## Data Model

> **Note**: Phase 2.1 is a UI-only phase with no persistent data. Data models (Transaction, Budget, Streak) are implemented in later phases (Phase 4, 6).

### UI State Models (for reference)

| Model | Purpose | Fields |
|-------|---------|--------|
| ThemeData | App-wide styling | colors, typography, spacing |
| ComponentConfig | Widget styling variants | primary, secondary, outlined, text |

### Entities from Feature Spec

| Entity | Description |
|--------|-------------|
| Design Tokens | Visual design values from Google Stitch |
| Reusable Widget | UI component with encapsulated styling |
| Screen | Complete UI page |
| Feature Module | Feature folder with presentation layer |

## Contracts

> **Note**: This is a UI implementation phase with no external interfaces. No contracts needed.

---

## Agent Context Update

```text
New Technologies Added:
- Google Stitch MCP (design token generation)
- screen_util_flutter (responsive sizing)

Existing Technologies (from previous phases):
- Flutter/Dart
- flutter_bloc (Cubit)
- supabase_flutter
- go_router
- get_it
- equatable
- google_fonts
```
