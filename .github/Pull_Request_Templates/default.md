# Pull Request Checklist

## Code Review Checklist

Please complete this checklist before requesting review:

### Architecture (Clean Architecture)
- [ ] Data Layer Separation: Code related to data fetching/storage is in `data/` directory
- [ ] Domain Layer Separation: Business logic entities and use cases are in `domain/` directory
- [ ] Presentation Layer Separation: UI components, widgets, and Cubits are in `presentation/` directory
- [ ] No Layer Coupling: Presentation layer does not import other feature's presentation layer directly

### State Management (Cubit)
- [ ] Single Cubit Per Feature: Only one Cubit manages state for this feature
- [ ] State Class: Feature has dedicated state class
- [ ] State Immutability: State uses `final` fields with immutable collections
- [ ] Proper use of `emit()` for state changes

### Widget Efficiency (Flutter)
- [ ] Const Constructors: Widgets use `const` where possible
- [ ] Efficient Rebuilds: Using `BlocBuilder` or `CubitBuilder` with `buildWhen`
- [ ] List Performance: Long lists use `ListView.builder`

### Naming Conventions
- [ ] File Names: Use lowercase with underscores
- [ ] Class Names: Use PascalCase
- [ ] Feature Folder Names: Use lowercase with underscores

### Tests
- [ ] Unit tests for business logic in domain layer
- [ ] Widget tests for UI components

### Error Handling
- [ ] Async operations wrapped in try-catch
- [ ] Errors displayed to user with meaningful messages
- [ ] UI shows appropriate fallback when errors occur

## Performance (if applicable)
- [ ] Cold start time remains under 3 seconds
- [ ] No obvious performance regressions

---

**Full checklist**: [docs/code-review-checklist.md](../../docs/code-review-checklist.md)

**Reviewer**: Please verify all mandatory items are checked before approving merge.
