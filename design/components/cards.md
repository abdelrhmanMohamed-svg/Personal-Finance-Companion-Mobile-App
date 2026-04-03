# Card Components Design

**Task**: T010 - Design card components

## Transaction Card

### Structure
- **Height**: 72px
- **Layout**: Row with icon | content | amount
- **Padding**: 12px horizontal
- **Background**: Surface color

### Left Section (Icon)
- **Container**: 40x40px circle
- **Background**: Category color at 10% opacity
- **Icon**: Category icon, 24px, category color
- **Border Radius**: 8px

### Center Section (Content)
- **Title**: `title-md`, primary text color
- **Subtitle**: `body-sm`, secondary text color (category, date)

### Right Section (Amount)
- **Amount**: `amount-sm`, right-aligned
- **Income**: Green color, "-" prefix (e.g., "- $500.00")
- **Expense**: Red color, "+" prefix (e.g., "+ $50.00")
- **Date**: `body-sm`, tertiary text color, below amount

### States
- **Default**: White background
- **Pressed**: Gray background at 5% opacity
- **Selected**: Primary border, light primary background

## Summary Card

### Structure
- **Padding**: 16px
- **Border Radius**: 12px
- **Background**: Surface color
- **Shadow**: `shadow-md`

### Balance Card (Dashboard)
- **Title**: "Total Balance", `title-sm`, secondary color
- **Amount**: `display-sm`, primary text (large balance)
- **Change Indicator**: Arrow + percentage, success/error color
- **Period**: "This month", `body-sm`, tertiary color

### Income/Expense Card
- **Title**: "Income" / "Expenses", `title-sm`
- **Amount**: `amount-lg`, success/error color
- **vs Last Month**: `body-sm`, comparison text

## Goal Card

### Structure
- **Padding**: 16px
- **Border Radius**: 12px
- **Background**: Surface color

### Progress Section
- **Progress Bar**: Height 8px, rounded, gray background
- **Fill**: Primary green, animated width
- **Percentage**: `label-md`, right of bar

### Details Section
- **Goal Name**: `title-md`
- **Target Amount**: `amount-sm`, secondary text
- **Current Amount**: `amount-md`, primary text
- **Target Date**: `body-sm`, tertiary text

### States
- **On Track**: Green progress bar, green percentage
- **Behind**: Warning (amber) progress bar
- **Completed**: 100%, celebration icon, success color

## Quick Stats Card

### Structure
- **Padding**: 16px
- **Border Radius**: 12px
- **Background**: Surface color
- **Size**: Half-width (2-column grid)

### Content
- **Icon**: 24px, primary color, top-left
- **Label**: `body-sm`, secondary color
- **Value**: `amount-md`, primary text
- **Trend**: Optional, small indicator

## Usage Guidelines

1. Use Transaction Card for transaction lists
2. Use Summary Card for dashboard aggregates
3. Use Goal Card for savings goals display
4. Use Quick Stats for dashboard metrics
5. Maintain consistent padding and spacing
6. Use category colors for icons
7. Show amount colors based on type
8. Support press/tap states with feedback
