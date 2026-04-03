# Quickstart: Phase 1: Project Setup and Architecture

**Generated**: 2026-04-03
**Feature**: Phase 1: Project Setup and Architecture

## Prerequisites

- Flutter SDK 3.x (latest stable)
- Dart SDK 3.x
- Supabase account (for backend)

## Setup Steps

### 1. Initialize Flutter Project

```bash
flutter create personal_finance_companion
cd personal_finance_companion
```

### 2. Add Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.0
  supabase_flutter: ^2.10.0
  go_router: ^15.1.0
  get_it: ^8.0.3
  equatable: ^2.0.7
  intl: ^0.20.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^10.0.0
  mocktail: ^1.0.4
  flutter_lints: ^5.0.0
```

### 3. Create Folder Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   ├── utils/
│   ├── services/
│   └── constants/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── [placeholder for future features]
├── shared/
│   ├── widgets/
│   └── models/
└── routes/
```

### 4. Configure Environment Variables

Create a `.env` file (add to .gitignore):

```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
```

### 5. Initialize Supabase Client

In `lib/core/services/supabase_service.dart`:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;
  
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }
}
```

### 6. Set Up Dependency Injection

In `lib/core/services/dependency_injection.dart`:

```dart
import 'package:get_it/get_it.dart';
import 'supabase_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Services
  getIt.registerLazySingleton(() => SupabaseService.client);
}
```

### 7. Configure Routing

In `lib/routes/app_router.dart`:

```dart
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Routes will be added in later phases
  ],
);
```

### 8. Run the App

```bash
flutter run
```

## Verification

Verify the setup by checking:

1. ✅ `flutter pub get` completes without errors
2. ✅ App builds and runs (even if just showing a placeholder)
3. ✅ No console errors on startup

## Next Steps

After Phase 1 completes:
- Proceed to Phase 2: Design System and Core UI
- Implement authentication (Phase 3)
- Implement transactions (Phase 4)

## Troubleshooting

### Common Issues

- **Supabase connection fails**: Check URL and anon key are correct
- **Build errors**: Run `flutter clean` then `flutter pub get`
- **Import errors**: Verify folder structure matches the pattern
