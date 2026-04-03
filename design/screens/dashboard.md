# Dashboard Screen Design

**Task**: T025 - Design Dashboard screen

## Screen Overview

The Dashboard is the main home screen showing financial overview at a glance.

## Layout Structure

### Header Section
- **App Title**: "Personal Finance" or user name
- **Settings Icon**: Top right, gear icon
- **Safe Area**: Respect notch/status bar

### Balance Card Section
- **Card Type**: Summary Card (Balance Card)
- **Title**: "Total Balance"
- **Amount**: `display-sm` (36px), large balance display
- **Period**: "As of [Date]"
- **Padding**: 16px

### Summary Cards Row
- **Layout**: Horizontal row, 2 cards
- **Card 1**: Income Card
  - Title: "Income"
  - Amount: `amount-md`, success green
  - Period: "This month"
- **Card 2**: Expenses Card
  - Title: "Expenses"
  - Amount: `amount-md`, error red
  - Period: "This month"

### Recent Transactions Section
- **Section Header**: "Recent Transactions"
- **View All Link**: Right-aligned, "See All" text
- **List**: Last 5 transactions (Transaction Cards)
- **Empty State**: If no transactions

### Quick Stats Row
- **Layout**: 2-column grid
- **Card 1**: "Monthly Savings"
- **Card 2**: "Active Goals"

### Bottom Navigation
- **Items**: Home, Transactions, Add, Goals, Insights
- **FAB**: Add Transaction in center

## Visual Design

### Colors
- Background: `#FAFAFA` (light) / `#121212` (dark)
- Cards: White (light) / `#1E1E1E` (dark)
- Primary: `#2E7D32`
- Income: `#43A047`
- Expense: `#E53935`

### Typography
- Screen title: `headline-lg`
- Section headers: `headline-sm`
- Card titles: `title-sm`
- Amounts: `amount-md` / `amount-lg`
- Body: `body-md`

### Spacing
- Screen padding: 16px
- Card padding: 16px
- Section spacing: 24px
- Card gap: 16px
- Card border radius: 12px

## Interactions

### Tap on Balance Card
- Navigate to detailed balance view (future)

### Tap on "See All" (Transactions)
- Navigate to Transactions List screen

### Tap on Transaction
- Navigate to Transaction Detail screen

### Tap on FAB (+)
- Navigate to Add Transaction screen

### Pull to Refresh
- Refresh all dashboard data

### Bottom Nav
- Tap to navigate between tabs

## States

### Loading
- Show Skeleton loaders for cards
- Show shimmer effect

### Empty
- Show "No transactions yet" message
- Show "Add your first transaction" CTA

### Error
- Show error card with retry button

### Data Loaded
- Show all cards with data
- Animate value changes

## Responsive

### Small Devices (< 360px)
- Reduce card padding to 12px
- Stack summary cards vertically

### Large Devices (> 414px)
- Increase screen padding to 20px
- Larger card padding
