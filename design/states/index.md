# State Management Guide

**Task**: T035 - Create state management guide

## Overview

This guide documents how to handle loading, empty, and error states across the app.

## State Types

### Loading States
- Skeleton loaders for content
- Spinners for actions
- Progress indicators for known durations

### Empty States
- No data to display
- User needs to add data
- Provide CTA to add data

### Error States
- Network failures
- Data load failures
- Action failures

## State Management Pattern

### ViewModel/Cubit Pattern

Each screen should have its own Cubit managing:

```dart
// Screen State
sealed class ScreenState {
  loading();
  loaded(data);
  empty();
  error(message);
}
```

### State Transitions

```
App Start
    │
    ▼
[Loading State] ──► [Loaded State] ──► [Data Display]
    │                   │                    │
    │                   │                    ▼
    │                   │              [Empty State]
    │                   │                    │
    ▼                   ▼                    ▼
[Error State] ◄────── [Retry] ────────── [User Action]
```

## Implementation Guidelines

### 1. Loading State
- Show immediately on init
- Minimum 200ms delay before showing
- Use skeleton for content areas

### 2. Loaded State
- Hide loading indicators
- Display actual content
- Animate transitions

### 3. Empty State
- Check data length == 0
- Show friendly message
- Provide CTA to add data

### 4. Error State
- Catch exceptions
- Show error message
- Provide retry option

## Shared Components

### LoadingView
```dart
- SkeletonCard
- ShimmerList
- InlineSpinner
- ProgressBar
```

### EmptyView
```dart
- EmptyStateWidget
- Illustration + Title + Description + CTA
```

### ErrorView
```dart
- ErrorCard
- RetryButton
- ErrorMessage
```

## Screen-Specific States

### Dashboard
- Loading: Skeleton cards
- Empty: Recent transactions empty
- Error: Dashboard load failed

### Transactions List
- Loading: Skeleton list
- Empty: No transactions
- Error: Load failed

### Transaction Form
- Loading: Pre-populate on edit
- Error: Save failed

### Goals
- Loading: Skeleton cards
- Empty: No goals
- Error: Load failed

### Insights
- Loading: Skeleton charts
- Empty: Not enough data
- Error: Load failed

## Best Practices

1. **Consistency**: Use same patterns across screens
2. **Feedback**: Always show state changes
3. **Recovery**: Provide retry for errors
4. **Clarity**: Use specific messages
5. **Performance**: Don't block UI unnecessarily
