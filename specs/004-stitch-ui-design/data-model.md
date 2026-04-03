# Data Model: Phase 2.0 - UI/UX Design Generation (Google Stitch)

**Phase 1 Output** | **Date**: 2026-04-04

## Design Token Model

### Color Tokens

| Token | Description | Usage |
|-------|-------------|-------|
| primary | Main brand color | Buttons, highlights, links |
| secondary | Supporting brand color | Secondary actions, accents |
| accent | Highlight color | Notifications, badges |
| success | Positive state | Confirmations, income |
| warning | Caution state | Alerts, budget warnings |
| error | Negative state | Errors, expenses |
| info | Informational state | Tips, neutral info |
| background.light | Light mode background | Screen backgrounds |
| background.dark | Dark mode background | Screen backgrounds |
| surface.light | Light mode surface | Cards, dialogs |
| surface.dark | Dark mode surface | Cards, dialogs |

### Typography Tokens

| Token | Size | Weight | Usage |
|-------|------|--------|-------|
| heading-1 | 32px | Bold (700) | Screen titles |
| heading-2 | 24px | SemiBold (600) | Section headers |
| heading-3 | 20px | SemiBold (600) | Card titles |
| body-large | 16px | Regular (400) | Primary content |
| body-medium | 14px | Regular (400) | Secondary content |
| body-small | 12px | Regular (400) | Captions, hints |
| label | 14px | Medium (500) | Button text, labels |
| button | 16px | SemiBold (600) | Button labels |

### Spacing Tokens

| Token | Value | Usage |
|-------|-------|-------|
| spacing-xs | 4px | Tight gaps, icon padding |
| spacing-sm | 8px | Compact elements |
| spacing-md | 16px | Default padding |
| spacing-lg | 24px | Section spacing |
| spacing-xl | 32px | Major section gaps |
| spacing-2xl | 48px | Screen margins |

### Shape Tokens

| Token | Value | Usage |
|-------|-------|-------|
| radius-sm | 4px | Small elements, chips |
| radius-md | 8px | Buttons, inputs |
| radius-lg | 12px | Cards, dialogs |
| radius-xl | 16px | Large cards |
| radius-full | 9999px | Circular elements |

### Touch Target Tokens

| Token | Value | Usage |
|-------|-------|-------|
| touch-minimum | 44x44px | Minimum touch target |
| button-height | 48px | Standard button height |
| input-height | 48px | Input field height |
| list-item-height | 56px | List item height |

## Component Specifications

### Button Components

| Component | States | Properties |
|-----------|--------|------------|
| PrimaryButton | default, pressed, disabled, loading | background: primary, text: white |
| SecondaryButton | default, pressed, disabled, loading | background: transparent, border: primary, text: primary |
| TextButton | default, pressed, disabled | text: primary |
| IconButton | default, pressed, disabled | icon only, circular |

### Input Components

| Component | States | Properties |
|-----------|--------|------------|
| TextField | default, focused, error, disabled | border, label, helper text |
| NumberField | default, focused, error, disabled | numeric keyboard, validation |
| DatePicker | default, selected | calendar popup |
| Dropdown | default, expanded, disabled | options list |

### Display Components

| Component | Properties |
|-----------|------------|
| TransactionCard | amount, category, date, note, type (income/expense) |
| SummaryCard | title, value, trend indicator |
| GoalCard | title, progress, streak, status |
| EmptyState | icon, message, call-to-action |

### Feedback Components

| Component | Properties |
|-----------|------------|
| LoadingIndicator | size, color |
| Snackbar | message, action, duration |
| Dialog | title, content, actions |

## Screen Layouts

### Dashboard Screen

- Balance card (top)
- Income/Expense summary (middle)
- Recent transactions list (bottom)
- Quick action FAB

### Transactions Screen

- Search/filter bar (top)
- Transaction list (scrollable)
- Add transaction button (FAB)
- Category filter chips

### Goals Screen

- Budget cards (top section)
- Streak display (middle section)
- Progress indicators

### Insights Screen

- Category breakdown chart
- Weekly/monthly toggle
- Top spending categories list

## Validation Rules

1. All interactive elements MUST meet minimum touch target size (44x44px)
2. All color combinations MUST meet WCAG AA contrast ratio (4.5:1)
3. Typography MUST maintain consistent hierarchy
4. Spacing MUST follow 8px grid system
5. All components MUST support both light and dark themes
