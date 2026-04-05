# Research: Transactions Module

## Overview

Phase 0 research consolidated from `/speckit.clarify` session decisions.

## Key Decisions

### 1. Offline Data Handling
- **Decision**: Queue transactions locally and sync when online
- **Rationale**: Ensures data isn't lost during connectivity issues; common pattern for mobile finance apps
- **Alternatives considered**: Immediate fail on offline (bad UX), background sync only (data loss risk)

### 2. Category Storage Structure
- **Decision**: Pre-defined system categories (no custom categories in Phase 4)
- **Rationale**: Keeps Phase 4 scope focused; custom categories can be added in future phases
- **Alternatives considered**: User-customizable category table (complex), free-form text (not searchable)

### 3. Database Schema & Security
- **Decision**: UUID primary keys with Row Level Security (RLS) enabled
- **Rationale**: Best practice for Supabase; UUIDs work well for distributed systems; RLS ensures user data isolation (critical for financial data)
- **Alternatives considered**: Auto-increment (not distributed-friendly), app-level filtering (less secure)

### 4. Database Migration Strategy
- **Decision**: Use Supabase CLI migrations
- **Rationale**: Version-controlled, reviewable, testable, and can be rolled back
- **Alternatives considered**: Direct dashboard creation (not tracked), manual SQL scripts (less integrated)

### 5. Additional Tables
- **Decision**: Defer Budget and Streak tables to future phases
- **Rationale**: Phase 4 scope focused on transactions only; Budget/Streak are Phase 6 features
- **Alternatives considered**: Creating all tables now (scope creep)

## Technology Stack (from Constitution)

- **Frontend**: Flutter (Dart) with Material Design 3
- **State Management**: Cubit from flutter_bloc
- **Backend**: Supabase (Auth + PostgreSQL)
- **Architecture**: Feature-based + Clean Architecture hybrid

## References

- Supabase CLI Documentation: https://supabase.com/docs/guides/cli
- flutter_bloc Cubit pattern: https://pub.dev/packages/flutter_bloc
- Row Level Security: https://supabase.com/docs/guides/auth/row-level-security
