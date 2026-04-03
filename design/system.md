# Design System Documentation

**Task**: T018 - Create comprehensive design system documentation

## Overview

This document provides a comprehensive overview of the Personal Finance Companion design system. It serves as the single source of truth for all design decisions and provides guidance for implementing the design in Flutter.

## Design Tokens

### Colors

The color system uses a semantic naming approach:

- **Primary**: `#2E7D32` (Brand Green)
- **Secondary**: `#1565C0` (Blue)
- **Success**: `#43A047`
- **Warning**: `#F9A825`
- **Error**: `#E53935`
- **Info**: `#1E88E5`

Full color palette defined in: `design/tokens/colors.md`

### Typography

- **Font Family**: Manrope (Google Fonts)
- **Scale**: Display, Headline, Title, Body, Label, Amount

Full typography scale defined in: `design/tokens/typography.md`

### Spacing

- **Base Unit**: 4px
- **Scale**: 4px to 96px
- **Standard Padding**: 16px

Full spacing system defined in: `design/tokens/spacing.md`

### Shapes

- **Border Radius**: 0px to 9999px (full)
- **Shadows**: None to XL

Full shapes system defined in: `design/tokens/shapes.md`

## Themes

### Light Theme
- Background: `#FAFAFA`
- Surface: `#FFFFFF`
- Text Primary: `#212121`

### Dark Theme
- Background: `#121212`
- Surface: `#1E1E1E`
- Text Primary: `#FAFAFA`

## Component Library

### Buttons
- Primary, Secondary, Text, Icon, FAB
- Sizes: Small (36px), Medium (48px), Large (56px)

### Inputs
- Text, Number, Amount, Date, TextArea
- Dropdown, Date Picker, Time Picker, Search

### Cards
- Transaction Card
- Balance Card
- Goal Card
- Quick Stats Card

### Feedback
- Loading (Skeleton, Spinner, Progress)
- Empty States
- Error States
- Toasts, Snackbars, Dialogs

### Navigation
- Bottom Navigation
- App Bar
- Tab Bar
- Drawer

## Screens

1. **Dashboard**: Balance overview, recent transactions
2. **Transactions**: Full transaction list with filters
3. **Transaction Form**: Add/Edit transactions
4. **Goals**: Savings goals management
5. **Insights**: Financial analytics

## States

- Loading States: Skeleton loaders, spinners
- Empty States: Friendly messages with CTAs
- Error States: Retry options, specific messages

## Accessibility

- WCAG AA compliant
- 48px minimum touch targets
- 4.5:1 contrast ratio for text
- 3:1 contrast ratio for UI components

## Implementation Guide

### Flutter Integration

```dart
// Use design tokens via ThemeExtension
class AppTheme extends ThemeExtension<AppTheme> {
  final Color primary;
  final Color secondary;
  // ... other tokens
}
```

### Key Files

| File | Purpose |
|------|---------|
| `design/tokens/export.json` | JSON token exports |
| `design/themes/light.md` | Light theme specs |
| `design/themes/dark.md` | Dark theme specs |
| `design/components/index.md` | Component inventory |

## Usage in Phase 2.1

All Flutter components should reference these design tokens. The tokens should be imported via the `design/tokens/export.json` file and applied through Flutter's theming system.

## Maintenance

When updating design tokens:
1. Update source files in `design/tokens/`
2. Regenerate `export.json`
3. Update Flutter theme extension
4. Update component implementations
