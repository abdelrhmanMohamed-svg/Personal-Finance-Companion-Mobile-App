# Quickstart: Phase 2.1 UI Implementation

## Prerequisites

1. Flutter SDK 3.x installed
2. Project dependencies installed: `flutter pub get`
3. Phase 2.0 (Design System) completed with design tokens available

## Getting Started

### 1. Obtain Design Tokens

**Primary**: Use Google Stitch MCP
```bash
# Run the Stitch MCP to generate design tokens
stitch generate-tokens --project personal_finance
```

**Fallback**: Use local design files
```bash
# Check design/ directory for token files
ls design/
```

### 2. Apply Theme

The theme configuration should be in `lib/core/theme/`:

```dart
// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(Map<String, dynamic> tokens) {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Color(int.parse(tokens['colors']['primary'])),
        // ... other colors
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: tokens['typography']['headline']['fontSize'],
          fontWeight: FontWeight.bold,
        ),
        // ... other text styles
      ),
    );
  }
}
```

### 3. Run the App

```bash
flutter run
```

## Development Workflow

1. **Theme First**: Apply design tokens to create unified theme
2. **Build Components**: Create reusable widgets in `lib/shared/widgets/`
3. **Build Screens**: Implement screens using components
4. **Test**: Verify screens render correctly on different screen sizes

## File Structure

```
lib/
├── core/theme/          # Theme configuration
├── shared/widgets/      # Reusable UI components
├── features/
│   ├── dashboard/presentation/
│   ├── transactions/presentation/
│   ├── goals/presentation/
│   └── insights/presentation/
```

## Testing

```bash
# Run widget tests
flutter test test/widget/

# Run on different screen sizes
flutter run -d <device_id>
```
