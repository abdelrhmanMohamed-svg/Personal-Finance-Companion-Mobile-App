# Goals Screen Design

**Task**: T028 - Design Goals screen

## Screen Overview

The Goals screen displays savings goals with progress tracking and allows users to create/manage goals.

## Layout Structure

### Header Section
- **Title**: "Goals"
- **Add Button**: Plus icon, top right

### Summary Section
- **Total Saved**: Sum of all goal progress
- **Active Goals**: Number of in-progress goals
- **Completed**: Number of completed goals
- **Layout**: Horizontal cards row

### Goals List
- **Item**: Goal Card component
- **Grouped**: By status (Active first, then Completed)
- **Empty State**: If no goals

### FAB (Add Goal)
- **Position**: Bottom right
- **Icon**: Plus sign
- **Color**: Primary green

## Goal Card Details

### Structure (per card)
- **Goal Name**: `title-md`
- **Icon**: Category/goal type icon
- **Progress Bar**: Percentage complete
- **Amounts**: Current / Target
- **Target Date**: Due date or "No deadline"

### Progress States
- **On Track**: Green progress bar (> 75%)
- **In Progress**: Blue progress bar (25-75%)
- **Behind**: Warning (amber) progress bar (< 25%)
- **Completed**: 100%, checkmark icon

### Actions (Long Press)
- Edit goal
- Delete goal
- Add contribution
- Mark as complete

## Add/Edit Goal Modal

### Fields
- **Name**: Text input, required
- **Target Amount**: Number input, required
- **Current Amount**: Number input, optional (for existing)
- **Category**: Dropdown (Emergency, Vacation, Car, Home, Other)
- **Target Date**: Date picker, optional
- **Icon**: Icon selector

### Actions
- Save Button
- Cancel

## Interactions

### Tap Goal Card
- Expand to show details
- Or navigate to goal detail screen

### Tap FAB
- Open Add Goal modal

### Pull to Refresh
- Refresh goals list

### Swipe to Delete
- Swipe left to reveal delete

## Empty State

- **Icon**: Piggy bank illustration, 120px
- **Title**: "No savings goals yet"
- **Description**: "Create a goal to start tracking your savings"
- **CTA**: "Create Goal" button

## States

### Loading
- Skeleton loaders for goal cards
- Shimmer effect

### Error
- Error card with retry
- "Failed to load goals"

### Empty
- Show empty state with CTA

### With Goals
- Show summary cards
- Show goals list

## Visual Design

### Colors
- Background: `#FAFAFA` (light) / `#121212` (dark)
- Card: Surface color
- Progress Green: `#43A047`
- Progress Warning: `#F9A825`
- Progress Blue: `#1565C0`

### Typography
- Screen title: `headline-lg`
- Section header: `title-sm`
- Goal name: `title-md`
- Amounts: `amount-sm`, `amount-md`
- Progress: `label-md`

### Spacing
- Screen padding: 16px
- Card padding: 16px
- Card gap: 16px
- Section spacing: 24px
