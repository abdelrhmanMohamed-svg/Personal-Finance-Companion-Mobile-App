# Research: Phase 1: Project Setup and Architecture

**Generated**: 2026-04-03
**Feature**: Phase 1: Project Setup and Architecture
**Branch**: 002-project-setup

## Research Questions

### Q1: What Flutter routing solution should be used?

**Decision**: go_router

**Rationale**: go_router is the recommended routing solution for Flutter by the Flutter team. It supports declarative routing, deep linking, and is well-suited for the navigation requirements in the spec (named routes, deep linking, state preservation).

**Alternatives considered**:
- `auto_route`: More complex setup, good code generation but adds build complexity
- `fluro`: Feature-rich but less community support currently
- Built-in Navigator: Too basic for the required features

---

### Q2: What dependency injection solution should be used?

**Decision**: get_it

**Rationale**: get_it is a popular service locator for Dart/Flutter that works well with Cubit and provides a clean API for registering and retrieving dependencies. It's widely used in the Flutter ecosystem.

**Alternatives considered**:
- `injectable`: Code generation based, more setup time
- `provider`: More suited for simple state management, less flexible for service injection
- Manual DI: Too manual for a scalable app

---

### Q3: How should environment configuration be managed?

**Decision**: flutter_config with environment variables

**Rationale**: Using environment-based configuration allows switching between dev/staging/prod without code changes. The Supabase credentials and API keys should be environment-specific.

**Alternatives considered**:
- Hardcoded config: Rejected - security and flexibility concerns
- JSON config files: Works but less standard than environment variables
- Build flavors: Good for mobile but environment variables are more flexible

---

### Q4: What is the recommended folder structure for feature-based architecture?

**Decision**: Each feature contains data/domain/presentation subdirectories

**Rationale**: This follows Clean Architecture principles and aligns with the constitution's requirement for isolated feature layers. The data layer handles repositories and data sources, domain layer contains entities and business logic, presentation layer handles UI and state management.

**Alternatives considered**:
- Single layer per feature: Rejected - violates clean architecture separation
- Only UI/business split: Insufficient for scalability

---

## Key Findings

1. **Flutter 3.x compatibility**: All recommended packages are compatible with Flutter 3.x latest stable
2. **Cubit pattern**: flutter_bloc provides Cubit which is the chosen state management - follows BLoC pattern
3. **Supabase setup**: supabase_flutter package provides all needed functionality for auth and database
4. **Testing strategy**: bloc_test for Cubit testing, flutter_test for widget tests

## Conclusion

All technical decisions align with the project constitution. No unresolved research questions remain.
