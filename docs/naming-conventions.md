# Naming Conventions

This document defines the naming standards for the Personal Finance Companion app.

## File Names

| Element | Convention | Example |
|---------|------------|---------|
| Dart files | lowercase_with_underscores | `user_service.dart` |
| Models | snake_case + _model suffix | `user_model.dart` |
| Cubits | snake_case + _cubit suffix | `auth_cubit.dart` |
| States | snake_case + _state suffix | `auth_state.dart` |
| Repositories | snake_case + _repository suffix | `user_repository.dart` |
| Widgets | snake_case + _widget suffix | `custom_button_widget.dart` |

## Class Names

| Element | Convention | Example |
|---------|------------|---------|
| Models | PascalCase | `UserModel` |
| Cubits | PascalCase | `AuthCubit` |
| States | PascalCase | `AuthState` |
| Repositories | PascalCase | `UserRepository` |
| Widgets | PascalCase | `CustomButtonWidget` |
| Services | PascalCase | `ValidationService` |

## Member Names

| Element | Convention | Example |
|---------|------------|---------|
| Private fields | underscore_prefix | `_userService` |
| Public fields | camelCase | `userName` |
| Constants | SCREAMING_SNAKE_CASE | `MAX_RETRY_COUNT` |
| Enum values | lowercase | `status.active` |

## Feature Folder Names

- Use lowercase with underscores
- Match feature name: `auth/`, `transactions/`, `dashboard/`

## Layer Directory Names

| Layer | Directory | Contents |
|-------|-----------|----------|
| Data | `data/` | Repositories, data sources, models |
| Domain | `domain/` | Entities, use cases, repository interfaces |
| Presentation | `presentation/` | Screens, widgets, cubits |

## Presentation Layer Structure

| Element | Directory | Contents |
|---------|-----------|----------|
| Cubit State | `cubits/` or `cubit/` | Cubit and state classes |
| Screens | `screens/` | Screen/Page widgets |
| Widgets | `widgets/` | Reusable UI components |

## Import Conventions

```dart
// Feature-local imports
import '../data/repositories/user_repository.dart';
import '../domain/entities/user.dart';

// Core imports
import '../../../core/theme/app_theme.dart';
```

## Abbreviations

| Instead of | Use |
|------------|-----|
| `btn` | `button` |
| `lbl` | `label` |
| `txt` | `text` |
| `num` | `number` |
| `msg` | `message` |
| `val` | `value` |

## Exceptions

- Maintain readability: Use full words for common terms
- API/URL acronyms: Keep uppercase for widely recognized terms
- iOS/Android: Keep platform names as-is
