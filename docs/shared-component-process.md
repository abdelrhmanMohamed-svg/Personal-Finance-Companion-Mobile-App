# Shared Component Process

This document defines the process for identifying and extracting duplicate UI patterns into shared components.

## Identifying Duplicate Patterns

### When to Look

During code review, scan for:
1. Similar widget structures across features
2. Repeated layout patterns (cards, lists, forms)
3. Common UI elements (buttons, inputs, loaders)

### How to Identify

1. **Visual Similarity**: Components that look the same
2. **Functional Similarity**: Components that do the same thing
3. **Structural Similarity**: Components with the same widget tree structure

### Examples

```dart
// Duplicated across features
// Feature A
ElevatedButton(
  onPressed: () {},
  child: Text('Submit'),
)

// Feature B  
ElevatedButton(
  onPressed: () {},
  child: Text('Submit'),
)
// → Extract to shared SubmitButton
```

## Criteria for Extraction

### When to Extract to lib/shared/

- Used in 3+ features
- No feature-specific business logic
- Can be made generic with parameters

### When to Extract to lib/core/

- Used across ALL features
- Fundamental UI building blocks
- Theme-related components

### When NOT to Extract

- Feature-specific styling
- Tightly coupled to feature's domain logic
- Likely to diverge over time

## Extraction Process

1. **Identify**: During code review, note duplicates
2. **Document**: Add to Shared Component Registry
3. **Design**: Create generic interface
4. **Implement**: Create in lib/shared/ or lib/core/
5. **Replace**: Update features to use shared component
6. **Test**: Verify functionality across features

## Shared Component Registry

| Name | Location | Used By | Description |
|------|----------|---------|-------------|
| CustomButton | lib/shared/widgets/ | auth, transactions | Reusable button with loading state |

See: [docs/shared-component-registry.md](shared-component-registry.md)

## Template

When creating a new shared component:

```dart
/// [ComponentName] - [Brief description]
///
/// Usage:
/// ```dart
/// SharedComponent(param: value)
/// ```
class SharedComponent extends StatelessWidget {
  /// [Parameter description]
  final Type param;
  
  const SharedComponent({
    super.key,
    required this.param,
  });
  
  @override
  Widget build(BuildContext context) {
    // Implementation
  }
}
```

## Documentation Requirements

Each shared component must have:
1. Purpose statement
2. Usage examples
3. Parameter descriptions
4. Any feature-specific customization points

## Maintenance

- Track usage across features
- Update all consumers when changing
- Don't break backward compatibility without migration path
