# Empty State Variations

**Task**: T033 - Design empty state variations

## Transaction Empty State

### Scenario
- No transactions recorded yet
- **Icon**: Wallet/empty wallet illustration (120px)
- **Title**: "No transactions yet"
- **Description**: "Your transactions will appear here once you add them"
- **CTA**: "Add Transaction" button

## Goals Empty State

### Scenario
- No savings goals created
- **Icon**: Piggy bank illustration (120px)
- **Title**: "No savings goals yet"
- **Description**: "Create a goal to start tracking your savings"
- **CTA**: "Create Goal" button

## Search Empty State

### Scenario
- No results for search query
- **Icon**: Magnifying glass (64px)
- **Title**: "No results found"
- **Description**: "Try adjusting your search or filters"
- **CTA**: "Clear Search"

## Filter Empty State

### Scenario
- Filter results in no matches
- **Icon**: Filter illustration (64px)
- **Title**: "No matching transactions"
- **Description**: "Try changing your filters"
- **CTA**: "Clear Filters"

## Insights Empty State

### Scenario
- Not enough data for insights
- **Icon**: Chart with question mark (64px)
- **Title**: "Not enough data"
- **Description**: "Add more transactions to see insights"
- **Requirements**: At least 5 transactions

## General Empty State

### Structure
- **Icon**: Centered, 64-120px based on context
- **Spacing**: 16px below icon
- **Title**: `headline-sm`, centered
- **Description**: `body-md`, secondary color, centered
- **CTA**: Centered below description
- **Max Width**: 300px for text

## Component Specifications

### Icon
- **Size**: 64px (inline) / 120px (full page)
- **Style**: Illustration or outline icon
- **Color**: Gray at 40% opacity

### Title
- **Style**: `headline-sm`
- **Color**: Primary text color

### Description
- **Style**: `body-md`
- **Color**: Secondary text color
- **Max Width**: 280px

### CTA Button
- **Style**: Primary button
- **Position**: Below description

## Usage Guidelines

1. Show empty state when there's no data
2. Provide actionable CTA to add data
3. Keep illustrations friendly and simple
4. Use consistent empty state patterns
5. Consider adding illustrations for each type
6. Don't show empty states during loading
7. Show specific empty state per context
