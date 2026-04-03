# Phase 2.1 Implementation Guide

**Task**: T039 - Create Phase 2.1 implementation guide

## Overview

This guide provides instructions for implementing the design system in Flutter (Phase 2.1). It assumes the design phase is complete and ready for code implementation.

## Prerequisites

- Flutter SDK 3.x installed
- Dart 3.x
- Project set up with dependencies:
  - `flutter_bloc`
  - `google_fonts`
  - `equatable`
  - `go_router`
  - `get_it`
  - `supabase_flutter` (for future phases)

## Implementation Steps

### Step 1: Set Up Design Tokens

Create a theme extension file:

```dart
// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color primary;
  final Color secondary;
  // ... add all design tokens

  AppTheme({required this.primary, ...});
}
```

### Step 2: Configure Light/Dark Themes

```dart
ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF2E7D32),
      // ...
    ),
    textTheme: GoogleFonts.manropeTextTheme(),
  );
}
```

### Step 3: Implement Components

Build components in order of dependency:

1. **Buttons** (`lib/components/buttons/`)
   - PrimaryButton
   - SecondaryButton
   - TextButton
   - IconButton
   - FAB

2. **Inputs** (`lib/components/inputs/`)
   - TextInputField
   - AmountInputField
   - DatePickerField
   - DropdownField

3. **Cards** (`lib/components/cards/`)
   - TransactionCard
   - SummaryCard
   - GoalCard
   - QuickStatsCard

4. **Feedback** (`lib/components/feedback/`)
   - LoadingView (skeleton, spinner)
   - EmptyView
   - ErrorView
   - Toast

5. **Navigation** (`lib/components/navigation/`)
   - BottomNavBar
   - AppBar
   - TabBar

### Step 4: Implement Screens

Build screens using the component library:

1. **Dashboard** - Main home screen
2. **Transactions List** - Transaction history
3. **Transaction Form** - Add/Edit
4. **Goals** - Savings goals
5. **Insights** - Analytics

### Step 5: Add State Management

Use Cubit for each screen:
- DashboardCubit
- TransactionsCubit
- GoalsCubit
- InsightsCubit

### Step 6: Add Routing

Configure GoRouter for navigation.

## File Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── spacing.dart
│   └── constants/
├── components/
│   ├── buttons/
│   ├── inputs/
│   ├── cards/
│   ├── feedback/
│   └── navigation/
├── screens/
│   ├── dashboard/
│   ├── transactions/
│   ├── goals/
│   └── insights/
├── widgets/  (shared widgets)
└── main.dart
```

## Design Token Reference

### Colors
- Primary: `#2E7D32`
- Secondary: `#1565C0`
- Success: `#43A047`
- Warning: `#F9A825`
- Error: `#E53935`
- Info: `#1E88E5`

### Typography
- Font: Manrope
- Display: 57/45/36px
- Headline: 32/28/24px
- Title: 22/16/14px
- Body: 16/14/12px
- Label: 14/12/11px
- Amount: 34/24/18px

### Spacing
- Base: 4px
- Scale: 4, 8, 12, 16, 20, 24, 32, 40, 48, 64

### Shapes
- Button radius: 8px
- Card radius: 12px
- Input radius: 8px

## Common Patterns

### Loading State
```dart
if (state is Loading) {
  return LoadingView();
}
```

### Error State
```dart
if (state is Error) {
  return ErrorView(
    message: state.message,
    onRetry: () => context.read<Cubit>().fetch(),
  );
}
```

### Empty State
```dart
if (state is Empty) {
  return EmptyView(
    icon: Icons.wallet,
    title: 'No transactions yet',
    onAction: () => navigateToAdd(),
  );
}
```

## Testing Checklist

- [ ] Light theme renders correctly
- [ ] Dark theme renders correctly
- [ ] All button states work
- [ ] All input validations work
- [ ] Navigation works correctly
- [ ] Loading states display
- [ ] Empty states display
- [ ] Error states display with retry
- [ ] Accessibility: 48px touch targets
- [ ] Accessibility: Color contrast

## Notes

- Use `design/tokens/export.json` for programmatic token access
- Reference `design/components/` for component specs
- Reference `design/screens/` for layout specs
- Follow existing patterns in codebase

## Next Steps

After Phase 2.1 implementation:
- Phase 3.0: Data layer implementation
- Phase 4.0: Feature development
- Phase 5.0: Polish & testing
