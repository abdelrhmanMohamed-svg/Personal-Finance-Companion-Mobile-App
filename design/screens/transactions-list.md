# Transactions List Screen Design

**Task**: T026 - Design Transactions list screen

## Screen Overview

The Transactions screen displays all transactions in a filterable, sortable list.

## Layout Structure

### Header Section
- **Title**: "Transactions"
- **Search Icon**: Top right
- **Filter Icon**: Next to search

### Filter Chips Row
- **Layout**: Horizontal scroll
- **Chips**: All, Income, Expense, [Category], [Date Range]
- **Selected**: Filled primary color
- **Unselected**: Outlined

### Date Group Headers
- **Format**: "Today", "Yesterday", "March 28, 2026"
- **Style**: `label-md`, secondary text color
- **Sticky**: Sticks to top while scrolling

### Transaction List
- **Item**: Transaction Card (72px height)
- **Grouped**: By date
- **Divider**: Between items (full width)

### FAB (Add Transaction)
- **Position**: Bottom right
- **Icon**: Plus sign
- **Color**: Primary green
- **Shadow**: Elevation 3

## Filter & Search

### Search Bar (Expandable)
- **Trigger**: Tap search icon
- **Input**: Full-width search field
- **Placeholder**: "Search transactions..."
- **Clear Button**: X icon when text present
- **Close**: Tap outside or X to close

### Filter Modal
- **Trigger**: Tap filter icon
- **Options**:
  - Type: All, Income, Expense, Transfer
  - Category: Multi-select chips
  - Date Range: Presets + Custom
  - Amount Range: Min/Max inputs
- **Apply Button**: Primary button
- **Reset**: Text button

## Interactions

### Tap Transaction
- Navigate to Transaction Detail

### Long Press Transaction
- Show context menu (Edit, Delete, Duplicate)

### Swipe Left on Transaction
- Reveal delete action (red)

### Swipe Right on Transaction
- Reveal edit action (blue)

### Pull to Refresh
- Refresh transaction list

### Load More
- Infinite scroll, load 20 at a time

## Empty State

- **Icon**: Wallet illustration, 120px
- **Title**: "No transactions yet"
- **Description**: "Your transactions will appear here"
- **CTA**: "Add Transaction" button

## States

### Loading
- Skeleton loader for list items (5 items)
- Shimmer effect

### Error
- Error card at top
- "Failed to load transactions"
- Retry button

### Filtering Active
- Show active filter count badge
- "Clear All" link

## Visual Design

### Colors
- Background: `#FAFAFA` (light) / `#121212` (dark)
- List item: Surface color
- Income: Success green
- Expense: Error red

### Typography
- Screen title: `headline-lg`
- Date header: `label-md`
- Transaction title: `title-md`
- Amount: `amount-sm`
- Date: `body-sm`

### Spacing
- Screen padding: 16px
- Item padding: 12px horizontal
- Section spacing: 24px
- Chip spacing: 8px
