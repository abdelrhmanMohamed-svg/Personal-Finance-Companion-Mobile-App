# Data Model: Phase 1: Project Setup and Architecture

**Generated**: 2026-04-03
**Feature**: Phase 1: Project Setup and Architecture

## Overview

Phase 1 is a foundational setup phase that establishes the project structure and configuration. While this phase does not implement domain-specific data models (those are defined in later phases like Phase 3-7), it establishes the architectural patterns and configuration entities needed to support all subsequent features.

## Configuration Entities

### Environment Configuration

| Field | Type | Description | Validation |
|-------|------|-------------|------------|
| supabaseUrl | String | Supabase project URL | Must be valid URL format |
| supabaseAnonKey | String | Supabase anonymous key | Required, non-empty |
| supabaseDebug | Boolean | Enable Supabase debug logging | Default: false |
| appEnvironment | Enum | dev, staging, prod | Default: dev |

### Project Structure Configuration

| Field | Type | Description |
|-------|------|-------------|
| featureDirectories | List<String> | Directories under lib/features/ |
| coreDirectories | List<String> | Directories under lib/core/ |
| sharedDirectories | List<String> | Directories under lib/shared/ |

## State Management Patterns

### Cubit Pattern

Each feature MUST implement one Cubit following this pattern:

```
feature_name_cubit.dart    # Cubit implementation
feature_name_state.dart   # State classes
feature_name_event.dart   # Event classes (if needed)
```

**State Classes**:
- Initial state for loading/initialization
- Loading state for async operations
- Loaded state with data
- Error state with failure information

## Validation Rules

### General Configuration
- Supabase URL must be a valid HTTPS URL
- Environment must be one of: dev, staging, prod
- Feature directories must follow naming convention (snake_case)

### State Management
- Each Cubit must emit states that are Equatable-comparable
- Error states must include failure message
- Loading states should be distinguished from initial states

## Relationships

```
App
├── Core Services
│   ├── Supabase Client (configured by Environment Configuration)
│   ├── Dependency Injection (get_it)
│   └── Theme Service
└── Features
    └── Each Feature has its own Cubit
```

## State Transitions

### Generic Feature State Machine

```
[Initial] --> [Loading] --> [Loaded]
    |            |
    +----> [Error]
```

## Notes

- This data model focuses on configuration and patterns, not domain entities
- Domain data models (Transaction, Budget, Streak) are defined in their respective phases
- The configuration entities here support the entire application lifecycle
