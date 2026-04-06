# Research: Theme Management (Light & Dark Mode)

**Date**: 2026-04-06
**Feature**: Theme Management

## Decisions Made

### Theme State Management

**Decision**: Use Cubit with hydrated bloc for persistence

**Rationale**: 
- Cubit is required by project constitution (Principle II)
- User explicitly requested hydrated bloc for persistence
- Hydrated bloc automatically persists state to local storage
- Minimal boilerplate compared to manual SharedPreferences

**Alternatives considered**:
- Manual SharedPreferences: More code, manual serialization
- Provider: Not cubit-based, violates constitution preference
- get_it + getX: Not following BLoC pattern

---

### Flutter Theme Implementation

**Decision**: Use ThemeMode enum with ThemeData for light/dark

**Rationale**:
- Native Flutter ThemeMode enum handles system/light/dark
- ThemeData provides complete theme configuration
- Works seamlessly with Material Design 3
- Standard pattern used across Flutter ecosystem

**Alternatives considered**:
- Custom theme enum: Unnecessary, Flutter provides native solution
- Third-party theme packages: Add dependency weight, native solution sufficient

---

### Hydrated Bloc Integration

**Decision**: Extend HydratedCubit instead of Cubit directly

**Rationale**:
- HydratedCubit automatically handles serialization/deserialization
- Simple to use - just override storage keys and state-to-json/from-json
- Works with existing Cubit patterns
- State persists across app restarts without additional code

**Alternatives considered**:
- Manual storage in Cubit: Requires SharedPreferences boilerplate
- HydratedBloc: Works but user specifically requested Cubit

---

## Best Practices Identified

1. Theme provider at MaterialApp level using BlocProvider
2. ThemeMode switch triggers rebuild of all themed widgets
3. Color constants defined centrally in app_theme.dart
4. ThemeCubit initialized at app startup for immediate theme
5. Debounce rapid theme toggles to prevent storage thrashing

## Unknowns Resolved

- **Storage mechanism**: Hydrated storage (automatic JSON persistence)
- **State pattern**: HydratedCubit extending Cubit
- **Theme access**: InheritedWidget or BlocBuilder in widgets
- **System detection**: Flutter's PlatformDispatcher or MediaQuery

## Sources

- Flutter official documentation on ThemeMode
- hydrated_bloc package documentation
- flutter_bloc Cubit pattern best practices