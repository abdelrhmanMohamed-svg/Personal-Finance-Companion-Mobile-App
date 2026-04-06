# Code Review Checklist

This checklist must be completed for every pull request before merging.

## Categories

### 1. Architecture (Clean Architecture)

- [ ] **Data Layer Separation**: Code related to data fetching/storage is in `data/` directory
- [ ] **Domain Layer Separation**: Business logic entities and use cases are in `domain/` directory
- [ ] **Presentation Layer Separation**: UI components, widgets, and Cubits are in `presentation/` directory
- [ ] **No Layer Coupling**: Presentation layer does not import other feature's presentation layer directly
- [ ] **Dependency Direction**: Dependencies point inward (presentation → domain ← data)

### 2. State Management (Cubit)

- [ ] **Single Cubit Per Feature**: Only one Cubit manages state for this feature
- [ ] **State Class**: Feature has dedicated state class (not using primitive types only)
- [ ] **State Immutability**: State uses `final` fields with immutable collections
- [ ] **No Direct Cubit Access**: Other features access this feature's state through domain layer, not Cubit
- [ ] **Emitting States**: Proper use of `emit()` for state changes

### 3. Widget Efficiency (Flutter)

- [ ] **Const Constructors**: Widgets use `const` where possible
- [ ] **Efficient Rebuilds**: Using `BlocBuilder` or `CubitBuilder` with `buildWhen` for selective rebuilds
- [ ] **List Performance**: Long lists use `ListView.builder` or `SliverList`
- [ ] **Avoiding Rebuilds**: Expensive widgets wrapped in `RepaintBoundary` where needed

### 4. Naming Conventions

- [ ] **File Names**: Use lowercase with underscores (e.g., `user_service.dart`)
- [ ] **Class Names**: Use PascalCase (e.g., `UserService`)
- [ ] **Private Members**: Use underscore prefix (e.g., `_userService`)
- [ ] **Feature Folder Names**: Use lowercase with underscores matching feature name

### 5. Tests

- [ ] **Test Coverage**: Business logic in domain layer has unit tests
- [ ] **Widget Tests**: UI components render correctly
- [ ] **Test Naming**: Tests follow `feature_test.dart` pattern

### 6. Error Handling

- [ ] **Try-Catch**: Async operations wrapped in try-catch
- [ ] **User Feedback**: Errors displayed to user with meaningful messages
- [ ] **Fallback States**: UI shows appropriate fallback when errors occur

---

## Review Process

1. Developer completes self-review using this checklist
2. Submits PR with checklist status
3. Reviewer verifies all mandatory items checked
4. Feedback provided for any incomplete items

**Mandatory Items**: Architecture, State Management, Naming Conventions (items without [ ] are always required)

**Optional Items**: Widget Efficiency improvements, Test coverage for minor features
