# Component Inventory

**Task**: T013 - Create component inventory

## Overview

This document catalogs all UI components designed for the Personal Finance Companion app. Each component is built on the design system tokens and follows consistent patterns.

## Component List

### Buttons (T008)
| Component | Description | File |
|-----------|-------------|------|
| Primary Button | Filled green button, white text | `buttons.md` |
| Secondary Button | Outlined button, green border/text | `buttons.md` |
| Text Button | Text-only button, green text | `buttons.md` |
| Icon Button | Circular/square icon button | `buttons.md` |
| FAB | Floating action button | `buttons.md` |
| Button Sizes | Small (36px), Medium (48px), Large (56px) | `buttons.md` |

### Inputs (T009)
| Component | Description | File |
|-----------|-------------|------|
| Text Input | Single-line text field | `inputs.md` |
| Number Input | Numeric input with formatting | `inputs.md` |
| Amount Input | Currency input with $ prefix | `inputs.md` |
| Date Input | Date picker integration | `inputs.md` |
| TextArea | Multi-line text input | `inputs.md` |
| Dropdown | Selection dropdown | `inputs.md` |
| Date Picker | Calendar modal picker | `inputs.md` |
| Time Picker | Wheel time picker | `inputs.md` |
| Search Input | Search with icon | `inputs.md` |

### Cards (T010)
| Component | Description | File |
|-----------|-------------|------|
| Transaction Card | Transaction list item | `cards.md` |
| Balance Card | Account balance display | `cards.md` |
| Income/Expense Card | Income/expense summary | `cards.md` |
| Goal Card | Savings goal with progress | `cards.md` |
| Quick Stats Card | Dashboard metric card | `cards.md` |

### Feedback (T011)
| Component | Description | File |
|-----------|-------------|------|
| Skeleton Loader | Content placeholder | `feedback.md` |
| Spinner | Loading indicator | `feedback.md` |
| Progress Indicator | Linear progress bar | `feedback.md` |
| Empty State | No data placeholder | `feedback.md` |
| Error State | Error display | `feedback.md` |
| Toast | Transient notification | `feedback.md` |
| Snackbar | Bottom notification | `feedback.md` |
| Dialog | Confirmation dialog | `feedback.md` |

### Navigation (T012)
| Component | Description | File |
|-----------|-------------|------|
| Bottom Navigation | Main nav bar (5 items) | `navigation.md` |
| FAB | Floating action button in nav | `navigation.md` |
| Tab Bar | Secondary tab navigation | `navigation.md` |
| App Bar | Top navigation bar | `navigation.md` |
| Drawer | Side navigation drawer | `navigation.md` |

## Design Token Usage

Each component uses the following design tokens:

### Colors
- Primary: `#2E7D32` (brand green)
- Secondary: `#1565C0` (blue)
- Success: `#43A047` (green)
- Warning: `#F9A825` (amber)
- Error: `#E53935` (red)
- Gray scale: `#FAFAFA` to `#212121`

### Typography
- Font: Manrope
- Scale: Display, Headline, Title, Body, Label

### Spacing
- Base unit: 4px
- Scale: 4px to 96px

### Shapes
- Border radius: 0px to full (9999px)
- Shadows: None to XL

## Component States

All interactive components support:
- **Default**: Normal appearance
- **Hover**: Subtle background change
- **Pressed**: Slight scale or background shift
- **Disabled**: Reduced opacity (38%)
- **Loading**: Spinner or skeleton
- **Error**: Error color border/text
- **Focus**: Primary color ring

## Accessibility

- All components meet WCAG AA contrast ratios
- Minimum 48px touch targets
- Support for screen readers
- Focus indicators for keyboard navigation

## Implementation Notes

- Export as Flutter widgets in Phase 2.1
- Use design tokens via theme extension
- Support light/dark themes
- Maintain consistent spacing and sizing

## Files Reference

```
design/
├── tokens/
│   ├── colors.md          # Color palette
│   ├── typography.md      # Typography scale
│   ├── spacing.md         # Spacing system
│   ├── shapes.md          # Shapes & shadows
│   └── export.json        # Token exports
├── themes/
│   ├── light.md           # Light theme
│   └── dark.md            # Dark theme
└── components/
    ├── buttons.md         # Button components
    ├── inputs.md          # Input components
    ├── cards.md           # Card components
    ├── feedback.md        # Feedback components
    ├── navigation.md      # Navigation components
    └── index.md           # This file
```
