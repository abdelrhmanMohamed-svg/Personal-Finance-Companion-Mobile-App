# Error State Variations

**Task**: T034 - Design error state variations

## General Error

### Scenario
- Unexpected error occurred
- **Icon**: Warning circle with exclamation (64px)
- **Title**: "Something went wrong"
- **Description**: "An error occurred. Please try again."
- **CTA**: "Try Again" button

### Variations
- **Network Error**: "No internet connection"
- **Server Error**: "Server unavailable. Try again later."
- **Unknown Error**: "Something unexpected happened"

## Network Error

### Scenario
- No internet or connection timeout
- **Icon**: Cloud with X (64px)
- **Title**: "No internet connection"
- **Description**: "Check your connection and try again"
- **CTA**: "Try Again"
- **Auto-retry**: Optional, after 5 seconds

## Load Error (List/Screen)

### Scenario
- Failed to load data
- **Position**: Full screen or section-level
- **Icon**: Error icon
- **Title**: "Failed to load"
- **Description**: "Could not load [data type]"
- **CTA**: "Retry"

### Specifics
- Dashboard: "Failed to load dashboard"
- Transactions: "Failed to load transactions"
- Goals: "Failed to load goals"
- Insights: "Failed to load insights"

## Save Error (Form)

### Scenario
- Failed to save data
- **Display**: Inline error + toast
- **Field Highlight**: Show error on failed field
- **Toast**: "Failed to save. Please try again."
- **CTA**: "Retry" button

## Delete Error

### Scenario
- Failed to delete item
- **Display**: Dialog or toast
- **Message**: "Could not delete. Please try again."
- **Action**: Close and refresh list

## Auth Error

### Scenario
- Authentication failed
- **Display**: Full page or dialog
- **Title**: "Session expired" or "Login failed"
- **CTA**: "Log In Again"

## Error Card Component

### Structure
- **Padding**: 16px
- **Background**: Error light background (rgba(229, 57, 53, 0.1))
- **Border Radius**: 12px
- **Layout**: Icon | Content

### Content
- **Title**: `title-md`, error color
- **Description**: `body-md`, secondary text
- **CTA**: "Try Again" button

## Inline Error

### For Input Fields
- **Position**: Below input
- **Icon**: Error icon, 16px
- **Text**: Error message, `body-sm`
- **Color**: Error red

### Validation Errors
- Required: "This field is required"
- Invalid format: "Invalid format"
- Min/Max: "Must be between X and Y"

## Snackbar Error

### Usage
- Non-critical errors
- Background: Error red `#E53935`
- Text: White
- Duration: 5 seconds
- Action: Optional "RETRY"

## Component Specifications

### Error Icon
- **Size**: 48px (card) / 64px (full page)
- **Style**: Filled circle with exclamation
- **Color**: Error red

### Error Title
- **Style**: `title-lg` (full page) / `title-md` (card)
- **Color**: Error red

### Error Description
- **Style**: `body-md`
- **Color**: Secondary text

### Retry Button
- **Style**: Secondary button
- **Label**: "Try Again" or "Retry"

## Usage Guidelines

1. Show specific error messages
2. Provide retry options
3. Log errors for debugging
4. Don't expose sensitive info in errors
5. Use appropriate error level
6. Handle network errors gracefully
7. Show inline errors near relevant fields
