# Implementation Plan: Phase 7 - Insights Screen

**Branch**: `010-insights-screen` | **Date**: 2026-04-06 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/speckit.specify` for Phase 7: Insights Screen

## Summary

The Insights Screen feature provides users with financial analytics including spending by category breakdown, weekly spending comparison, monthly trends, and top spending category identification. All insights are calculated from existing transaction data in Supabase and displayed with visual charts.

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: flutter_bloc (Cubit), supabase_flutter, fl_chart (for data visualization)  
**Storage**: Supabase (PostgreSQL) - existing transaction data  
**Testing**: flutter_test, bloc_test  
**Target Platform**: iOS/Android (Mobile)  
**Project Type**: mobile-app  
**Performance Goals**: <2 seconds screen load (SC-001), <1 second empty state (SC-005)  
**Constraints**: Real-time updates on transaction changes, mobile-first responsive design  
**Scale/Scope**: Single user, local data isolation via Supabase RLS  

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| Feature-first architecture | ✅ Pass | Insights will use data/domain/presentation layers |
| Cubit state management | ✅ Pass | InsightsCubit will manage all insight states |
| Supabase integration | ✅ Pass | Uses existing transaction data, no new tables needed |
| Phase-gated development | ✅ Pass | Phase 7 per constitution sequence |

## Project Structure

### Documentation (this feature)

```text
specs/010-insights-screen/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output (skipped - internal only)
└── tasks.md            # Phase 2 output (/speckit.tasks)
```

### Source Code (repository root)

```text
lib/
├── features/
│   └── insights/
│       ├── data/
│       │   ├── models/
│       │   ├── repositories/
│       │   └── datasources/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
└── core/
    └── [shared utilities]
```

**Structure Decision**: Using existing Feature-first + Clean Architecture. Insights feature will follow the same pattern as Transactions and Dashboard features. No new external interfaces (internal feature only).

## Complexity Tracking

No violations to document. All implementation follows existing patterns.

---

# Phase 0: Research

## Research Tasks

### Task 1: Flutter Chart Packages

**Decision**: Use **fl_chart** package

**Rationale**:
- Lightweight (~500KB), well-maintained
- Supports PieChart (category breakdown), BarChart (weekly comparison), LineChart (monthly trends)
- Pure Dart, no native dependencies
- Used by many production Flutter apps

**Alternatives considered**:
- syncfusion_flutter_charts: Too heavy (~300MB), overkill for simple charts
- charts_flutter (Google): Deprecated, not recommended
- Custom Canvas: Too much custom code, maintainability concern

### Task 2: Real-time Data Updates Strategy

**Decision**: Use Cubit with emit on state changes + Supabase subscription

**Rationale**:
- Supabase supports Realtime subscriptions for table changes
- On navigation to Insights screen, fetch latest data
- Listen to transaction table changes and emit new states
- Already aligned with Constitution principle of Cubit state management

### Task 3: Performance Optimization

**Decision**: Calculate insights server-side via Supabase RPC, cache locally

**Rationale**:
- Mobile devices have limited processing for aggregations
- Server-side SQL aggregations are faster
- Cache results for current session
- Invalidate cache on transaction changes

**Alternatives considered**:
- Client-side calculation: Too slow for large transaction histories
- Background worker: Adds complexity, not needed for this scale

## Consolidated Research Findings

| Decision | Rationale |
|----------|-----------|
| fl_chart for visualization | Lightweight, sufficient features, well-maintained |
| Supabase Realtime for updates | Built-in, aligns with existing stack |
| Server-side aggregation | Performance optimization for mobile |
| Calendar week definition | Monday-Sunday (ISO 8601 standard) |
