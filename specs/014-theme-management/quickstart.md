# Quickstart: Theme Management Implementation

## Prerequisites

- Flutter 3.x project with flutter_bloc installed
- Add `hydrated_bloc` to pubspec.yaml

## Implementation Steps

### 1. Install Dependency

```yaml
# pubspec.yaml
dependencies:
  hydrated_bloc: ^9.1.0
```

### 2. Create Theme Configuration

**File**: `lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    // Define light colors
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    // Define dark colors
  );
}
```

### 3. Create Theme Cubit

**File**: `lib/features/settings/presentation/cubit/theme_cubit.dart`

```dart
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    emit(state.copyWith(themeMode: newMode));
  }

  void setSystemTheme(bool enabled) {
    emit(state.copyWith(
      themeMode: enabled ? ThemeMode.system : ThemeMode.light,
      systemThemeEnabled: enabled,
    ));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}

class ThemeState {
  final ThemeMode themeMode;
  final bool systemThemeEnabled;

  ThemeState({
    required this.themeMode,
    required this.systemThemeEnabled,
  });

  factory ThemeState.initial() => ThemeState(
    themeMode: ThemeMode.light,
    systemThemeEnabled: false,
  );

  ThemeState copyWith({ThemeMode? themeMode, bool? systemThemeEnabled}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      systemThemeEnabled: systemThemeEnabled ?? this.systemThemeEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
    'themeMode': themeMode.index,
    'systemThemeEnabled': systemThemeEnabled,
  };

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: ThemeMode.values[json['themeMode'] ?? 0],
      systemThemeEnabled: json['systemThemeEnabled'] ?? false,
    );
  }
}
```

### 4. Update MaterialApp

**File**: `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  HydratedBloc.storage = await HydratedStorage.build();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            // ... rest of app
          );
        },
      ),
    );
  }
}
```

### 5. Add Theme Toggle in Settings

In Settings screen, add a Switch or ToggleButtons to toggle between light/dark and enable system theme detection.

## Testing

- Unit test: ThemeCubit state transitions
- Widget test: Theme toggle UI interaction
- Integration: Theme persists across app restarts