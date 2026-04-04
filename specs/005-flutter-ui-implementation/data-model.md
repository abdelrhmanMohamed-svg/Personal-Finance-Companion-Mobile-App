# Data Model: Phase 2.1 UI Implementation

**Note**: This phase is UI-only with no persistent data storage. Data models for Transaction, Budget, and Streak are implemented in later phases.

---

## UI State Models

### ThemeData Configuration

| Field | Type | Description |
|-------|------|-------------|
| colors | ThemeColors | Primary, secondary, background, surface, error colors |
| typography | ThemeTypography | TextTheme with headline, body, label styles |
| spacing | ThemeSpacing | Predefined spacing values (xs, sm, md, lg, xl) |
| borderRadius | double | Default border radius for cards/buttons |

### Component Configuration

| Field | Type | Description |
|-------|------|-------------|
| buttonVariant | enum | primary, secondary, outlined, text |
| inputState | enum | default, focused, error, disabled |
| cardElevation | double | Shadow depth for card components |

---

## Design Tokens (Input)

Design tokens are obtained from Google Stitch MCP or local `design/` folder:

| Token Category | Example Fields |
|-----------------|----------------|
| Colors | primary, secondary, background, surface, error, onPrimary, onSecondary |
| Typography | fontFamily, headlineSizes, bodySizes, labelSizes |
| Spacing | xs (4px), sm (8px), md (16px), lg (24px), xl (32px) |
| Border Radius | sm (4px), md (8px), lg (12px), full (9999px) |

---

## Screen Definitions

| Screen | Components Required |
|--------|---------------------|
| Dashboard | BalanceCard, IncomeExpenseCard, QuickActions, ChartPlaceholder |
| Transactions List | TransactionCard, FilterChip, FAB |
| Add/Edit Transaction | AmountInput, CategoryPicker, DatePicker, NotesInput, SaveButton |
| Goals | GoalProgressCard, StreakBadge, BudgetCard |
| Insights | CategoryChart, TrendChart, TopCategoryCard |

---

## Widget Library

### Required Reusable Components

| Component | Variants | States |
|-----------|----------|--------|
| AppButton | primary, secondary, outlined, text | default, pressed, disabled, loading |
| AppInput | text, number, date | default, focused, error, disabled |
| AppCard | default, elevated, outlined | default, pressed |
| AppText | headline, title, body, label | N/A |
