# Personal Finance Companion - Architecture Documentation

## Project Structure

This project follows a **Feature-based + Clean Architecture** pattern.

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # App configuration with routing
├── core/                        # Core utilities and services
│   ├── config/                  # Environment configuration
│   │   └── environment.dart     # Environment enum and settings
│   ├── constants/               # App-wide constants
│   │   └── app_constants.dart   # Transaction categories, etc.
│   ├── cubits/                  # Global Cubit utilities
│   │   └── app_cubit_observer.dart
│   ├── services/                # Core services
│   │   ├── supabase_service.dart
│   │   └── dependency_injection.dart
│   ├── theme/                   # Theme configuration
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   └── utils/                   # Utility helpers
│       └── date_utils.dart
├── features/                    # Feature modules
│   ├── auth/
│   │   ├── data/                # Repositories, data sources
│   │   ├── domain/             # Entities, use cases
│   │   └── presentation/       # Screens, widgets, cubits
│   ├── transactions/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── dashboard/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── goals/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── insights/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── routes/                      # Routing configuration
│   ├── app_router.dart         # GoRouter configuration
│   └── route_names.dart        # Route name constants
└── shared/                      # Shared utilities
    ├── models/                  # Reusable models
    └── widgets/                 # Reusable widgets
```

## Architecture Principles

### 1. Feature-Based Organization
- Each feature (auth, transactions, dashboard, goals, insights) has its own folder
- Features are independent and can be developed in parallel

### 2. Clean Architecture Layers
Each feature follows:
- **data/**: Repositories, data sources, API clients
- **domain/**: Entities, use cases, business logic
- **presentation/**: UI screens, widgets, Cubits (state management)

### 3. State Management
- Uses **Cubit** pattern from flutter_bloc
- One Cubit per feature
- States are Equatable for efficient rebuilds

### 4. Dependency Injection
- Uses **get_it** for service locator
- All services are registered in `dependency_injection.dart`

### 5. Routing
- Uses **go_router** for declarative routing
- Route names defined in `route_names.dart`

## Core Services

### Supabase Service
- Handles Supabase client initialization
- Provides authentication methods
- Manages database connections

### Environment Configuration
- Supports dev, staging, prod environments
- Configurable Supabase URL and anon key
- Debug mode toggle

## Theme System

- Uses Material Design 3
- Light and dark theme support
- Custom colors, typography defined in core/theme/

## Naming Conventions

- **Files**: snake_case (e.g., `auth_cubit.dart`)
- **Classes**: PascalCase (e.g., `AuthCubit`)
- **Constants**: PascalCase with prefix (e.g., `AppConstants`)
- **Routes**: camelCase route names in `route_names.dart`

## Development Workflow

1. **Create feature folder**: Add new feature under `lib/features/`
2. **Implement layers**: Add data, domain, presentation subfolders
3. **Create Cubit**: Add state and cubit classes for state management
4. **Register services**: Add any new services to dependency_injection.dart
5. **Add routes**: Register new screens in app_router.dart

## Testing

- Unit tests: `test/unit/`
- Widget tests: `test/widget/`
- Integration tests: `test/integration/`

## Notes

- Placeholder screens will be replaced with UI from Google Stitch
- Supabase credentials should be in .env file (not committed)
- Run `flutter pub get` after any pubspec.yaml changes

## Code Quality

This project follows code quality standards defined in the `docs/` directory.

| Document | Description |
|----------|--------------|
| [docs/code-review-checklist.md](docs/code-review-checklist.md) | Mandatory checklist for all PRs |
| [docs/naming-conventions.md](docs/naming-conventions.md) | Naming standards |
| [docs/performance-baselines.md](docs/performance-baselines.md) | Performance targets |
| [docs/shared-component-process.md](docs/shared-component-process.md) | Reusable component process |

### Before Submitting a PR

1. Complete self-review using the code review checklist
2. Verify all naming conventions are followed
3. Ensure performance targets are still met