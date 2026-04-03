# Loading State Variations

**Task**: T032 - Design loading state variations

## Skeleton Loaders

### Transaction List Skeleton
- **Items**: 5 placeholder items
- **Height**: 72px each
- **Layout**: Icon circle (left), 2 lines (center), 1 line (right)
- **Animation**: Shimmer, left to right, 1.5s duration
- **Background**: Gray at 20% opacity

### Dashboard Cards Skeleton
- **Cards**: Balance card, Income/Expense cards
- **Layout**: Match actual card structure
- **Animation**: Shimmer effect

### Goals List Skeleton
- **Items**: 3-5 goal cards
- **Structure**: Icon, title lines, progress bar placeholder

### Chart Skeleton
- **Shape**: Match chart dimensions
- **Animation**: Shimmer with rounded corners

## Spinner States

### Inline Spinner
- **Size**: 24px
- **Usage**: Inside buttons, inline text
- **Color**: Primary green

### Page Spinner
- **Size**: 48px
- **Background**: Full page overlay
- **Text**: "Loading..." below

### Button Loading
- **Icon**: Replace with spinner
- **Text**: Hidden or "Loading..."
- **Disabled**: True during load

## Progress Indicators

### Linear Progress
- **Height**: 4px
- **Background**: Gray at 20%
- **Fill**: Primary green
- **Animation**: Indeterminate or percentage-based

### Circular Progress
- **Size**: 48px (page), 24px (inline)
- **Stroke**: 4px
- **Color**: Primary green

## Shimmer Effect

### Implementation
- **Colors**: Gray 20% → Gray 40% → Gray 20%
- **Direction**: Left to right
- **Duration**: 1.5s
- **Timing**: Linear, infinite

### Usage
- Skeleton loaders
- Content placeholders
- List items

## Pull to Refresh

### Indicator
- **Type**: Circular progress
- **Position**: Below app bar
- **Trigger**: Pull down gesture

### Animation
- **On Release**: Full spinner while loading
- **On Complete**: Animate out

## Usage Guidelines

1. Use skeleton loaders for lists and grids
2. Use spinners for quick operations
3. Use progress bars for known durations
4. Show shimmer while data loads
5. Provide loading state during navigation
6. Don't leave loading states too long
7. Use minimum 200ms delay before showing
