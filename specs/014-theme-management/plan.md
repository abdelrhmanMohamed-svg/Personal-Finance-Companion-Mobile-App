# Implementation Plan: Theme Management (Light & Dark Mode)

**Branch**: `014-theme-management` | **Date**: 2026-04-06 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/014-theme-management/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement light and dark theme switching with persistent user preference. Uses Cubit for state management with hydrated bloc for state persistence across app restarts. Theme toggle accessible from Settings screen with smooth animated transitions.

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: flutter_bloc (Cubit), hydrated_bloc  
**Storage**: Hydrated storage (local persistence)  
**Testing**: flutter_test, bloc_test  
**Target Platform**: iOS/Android mobile  
**Project Type**: mobile-app  
**Performance Goals**: Theme switch <1s, animation 0.3-0.5s  
**Constraints**: Offline-capable, no external API  
**Scale/Scope**: 1 feature, 4-5 screens affected

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| Feature-First Architecture | PASS | Theme feature follows data/domain/presentation structure |
| Cubit State Management | PASS | Using Cubit as specified, user requested hydrated bloc for persistence |
| Supabase Integration | N/A | No database needed for theme preference (local storage only) |
| Test-Driven Quality | [To verify] | Will include unit tests for Cubit |
| Phase-Gated Development | N/A | Phase 9 feature |

### Post-Phase 1 Re-evaluation

| Principle | Status | Notes |
|-----------|--------|-------|
| Feature-First Architecture | PASS | Theme config in core/theme, cubit in settings/presentation/cubit |
| Cubit State Management | PASS | Using HydratedCubit (extends Cubit) as specified |
| Supabase Integration | N/A | No database - local storage only |
| Test-Driven Quality | PASS | Quickstart includes test guidance |
| Phase-Gated Development | PASS | Following plan workflow |

## Project Structure

### Documentation (this feature)

```text
specs/014-theme-management/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (N/A - no external interfaces)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
├── core/
│   └── theme/           # Theme configuration (light/dark definitions)
└── features/
    └── settings/
        └── presentation/
            └── cubit/   # ThemeCubit for state management

# Hydrated storage handles persistence automatically
```

**Structure Decision**: Theme management is a cross-cutting concern. Theme configuration in `lib/core/theme/`, ThemeCubit in `lib/features/settings/presentation/cubit/`. Hydrated bloc persists state locally.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations - all gates pass.
