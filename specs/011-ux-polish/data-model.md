# Data Model: UX and Polish

**Date**: 2026-04-06  
**Feature**: Phase 8: UX and Polish

## Overview

This phase adds UI state entities for managing loading, empty, and error states across the application. No database changes required.

## Entities

### LoadingState

Represents the current state of data fetching operations.

| Field | Type | Description |
|-------|------|-------------|
| isLoading | bool | Whether loading is in progress |
| data | T? | Loaded data (nullable) |
| error | String? | Error message if failed |

**State Transitions**:
- Initial → Loading (on fetch start)
- Loading → Success (on data received)
- Loading → Error (on failure)

### EmptyState

Represents screens with no data to display.

| Field | Type | Description |
|-------|------|-------------|
| title | String | Primary message |
| message | String | Detailed guidance |
| actionLabel | String? | CTA button text |
| action | VoidCallback? | CTA handler |

### ErrorState

Represents failed operations.

| Field | Type | Description |
|-------|------|-------------|
| message | String | User-friendly error message |
| category | ErrorCategory | Type of error (network, data, system) |
| retryLabel | String? | Retry button text |
| retryAction | VoidCallback? | Retry handler |

### ErrorCategory (enum)

- `network` - Connectivity issues
- `data` - Database or data processing errors
- `system` - Unexpected system errors

## UI Components

### LoadingIndicator Widget
- Displays CircularProgressIndicator
- Optional custom styling
- Shimmer effect for skeleton loading

### EmptyStateWidget
- Reusable component for all empty states
- Customizable icon, title, message
- Optional action button

### ErrorStateWidget
- User-friendly error display
- Optional retry action
- Dismiss functionality

### AnimatedWidget
- Base widget for animations
- Respects Reduce Motion accessibility
- Configurable duration and curve

## Validation Rules

- Loading states must show within 200ms of operation start
- Error messages must not contain technical jargon
- Empty states must include actionable guidance
- Animations must respect accessibility settings

## Relationships

These state entities integrate with existing feature Cubits:
- DashboardCubit
- TransactionsCubit  
- GoalsCubit
- InsightsCubit

Each Cubit will expose LoadingState, EmptyState, or ErrorState alongside its main state.
