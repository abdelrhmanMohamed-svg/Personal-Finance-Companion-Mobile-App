# Feedback Components Design

**Task**: T011 - Design feedback components

## Loading States

### Skeleton Loader
- **Background**: Gray at 20% opacity
- **Animation**: Shimmer effect, left to right, 1.5s duration
- **Border Radius**: Match component shape
- **Usage**: Transaction list, cards placeholders

### Spinner
- **Size**: 24px (inline), 48px (full page)
- **Color**: Primary green
- **Style**: Circular, clockwise rotation
- **Duration**: 1s per rotation, infinite

### Progress Indicator (Linear)
- **Height**: 4px
- **Background**: Gray at 20% opacity
- **Fill**: Primary green, animated width
- **Usage**: Form submission, data loading

### Full Page Loading
- **Background**: Semi-transparent overlay
- **Spinner**: Centered, 48px
- **Text**: Optional, below spinner, "Loading..."

## Empty States

### Empty Transaction List
- **Icon**: Wallet illustration, 120px
- **Title**: "No transactions yet", `headline-sm`
- **Description**: "Tap + to add your first transaction", `body-md`
- **CTA Button**: "Add Transaction"

### Empty Goals
- **Icon**: Piggy bank illustration, 120px
- **Title**: "No savings goals", `headline-sm`
- **Description**: "Create a goal to start saving", `body-md`
- **CTA Button**: "Create Goal"

### Empty Search Results
- **Icon**: Magnifying glass, 64px
- **Title**: "No results found", `title-lg`
- **Description**: "Try adjusting your search", `body-md`

### Structure
- **Icon**: Centered, 64-120px
- **Spacing**: 16px below icon
- **Title**: Centered, below icon
- **Description**: Centered, below title, secondary color
- **CTA**: Centered, below description

## Error States

### Inline Error
- **Icon**: Error icon (exclamation), 16px, error color
- **Text**: Error message, `body-sm`, error color
- **Background**: Error light background
- **Padding**: 12px
- **Border Radius**: 8px

### Error Card
- **Icon**: Warning circle, 48px
- **Title**: "Something went wrong", `title-lg`
- **Description**: Error details, `body-md`
- **Retry Button**: Secondary button

### Network Error
- **Icon**: Cloud with X, 64px
- **Title**: "No internet connection"
- **Description**: "Check your connection and try again"
- **Retry Button**: "Try Again"

### Form Error
- **Position**: Below input field
- **Text**: `body-sm`, error color
- **Icon**: Optional, error icon left of text

## Toast Messages

### Success Toast
- **Background**: `#43A047` (success green)
- **Icon**: Checkmark, white, 20px
- **Text**: White, `body-md`
- **Duration**: 3 seconds
- **Position**: Top, below app bar, or bottom

### Error Toast
- **Background**: `#E53935` (error red)
- **Icon**: X circle, white, 20px
- **Text**: White, `body-md`
- **Duration**: 5 seconds (longer for error)
- **Position**: Top or bottom

### Info Toast
- **Background**: `#1565C0` (secondary blue)
- **Icon**: Info, white, 20px
- **Text**: White, `body-md`
- **Duration**: 3 seconds
- **Position**: Top or bottom

### Warning Toast
- **Background**: `#F9A825` (warning amber)
- **Icon**: Warning triangle, dark, 20px
- **Text**: Dark text, `body-md`
- **Duration**: 4 seconds
- **Position**: Top or bottom

### Toast Style
- **Border Radius**: 8px
- **Padding**: 12px horizontal, 16px vertical
- **Max Width**: 360px
- **Animation**: Slide in from top/bottom, fade out
- **Action Button**: Optional, "UNDO" or "RETRY"

## Snackbar (Bottom)

### Structure
- **Background**: `#323232` (dark gray)
- **Text**: White, `body-md`
- **Action**: Optional, "UNDO" button, primary color
- **Duration**: 4 seconds (short), 7 seconds (long)
- **Position**: Bottom, above navigation

### Usage
- Undo actions (transaction delete)
- Non-critical notifications
- Low-priority updates

## Confirmation Dialog

### Structure
- **Title**: Dialog title, `headline-sm`
- **Content**: Message, `body-md`
- **Actions**: Cancel (text), Confirm (primary)
- **Border Radius**: 16px (modal)

### Delete Confirmation
- **Title**: "Delete [Item]?"
- **Content**: "This action cannot be undone."
- **Actions**: Cancel, Delete (red)

## Usage Guidelines

1. Use skeleton loaders for content that takes time
2. Show inline errors near the relevant field
3. Use empty states when there's no data to show
4. Use toasts for transient feedback
5. Use dialogs for destructive actions
6. Always provide retry options for errors
7. Keep error messages actionable
