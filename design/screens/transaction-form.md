# Add/Edit Transaction Screen Design

**Task**: T027 - Design Add/Edit Transaction screen

## Screen Overview

The Transaction Form screen allows users to add new transactions or edit existing ones.

## Layout Structure

### Header
- **Title**: "Add Transaction" or "Edit Transaction"
- **Close**: X icon, top left
- **Save**: "Save" button, top right (disabled until valid)

### Form Sections

#### 1. Transaction Type Selector
- **Options**: Expense, Income, Transfer
- **Style**: Segmented control / toggle buttons
- **Default**: Expense

#### 2. Amount Input
- **Field**: Amount Input component
- **Prefix**: Currency symbol ($)
- **Size**: `display-sm` (large)
- **Keyboard**: Numeric with decimal
- **Required**: Yes

#### 3. Category Selector
- **Label**: "Category"
- **Type**: Grid of category chips or Dropdown
- **Required**: Yes
- **Categories**:
  - Food & Dining, Transportation, Shopping
  - Entertainment, Bills & Utilities, Health
  - Education, Travel, Groceries, Other

#### 4. Date & Time
- **Date Field**: Date picker, default today
- **Time Field**: Optional, time picker
- **Format**: MM/DD/YYYY, HH:MM AM/PM

#### 5. Account (From/To)
- **Expense**: "From" account (dropdown)
- **Income**: "To" account (dropdown)
- **Transfer**: "From" and "To" accounts

#### 6. Description
- **Field**: TextArea
- **Label**: "Note" or "Description"
- **Placeholder**: "Add a note..."
- **Max Length**: 500 characters
- **Required**: No

#### 7. Recurring (Optional)
- **Toggle**: "Repeat"
- **Options**: None, Daily, Weekly, Monthly, Yearly
- **End Date**: Optional

### Bottom Actions
- **Save Button**: Primary, full width
- **Cancel**: Text button (if needed)

## Interactions

### Form Validation
- Real-time validation on blur
- Show inline errors below fields
- Enable save button when valid

### Keyboard Handling
- Scroll to focused field
- Dismiss on tap outside

### Date Picker
- Tap to open calendar modal
- Select date to close

### Category Selection
- Tap category to select
- Show checkmark on selected

### Save Action
- Show loading state
- Validate all fields
- Save to storage
- Navigate back on success
- Show error toast on failure

## Edit Mode

### Pre-populate Fields
- Fill all fields with existing data
- Update title to "Edit Transaction"

### Delete Option
- Show delete button (red text)
- Confirmation dialog before delete
- Navigate back after delete

## States

### Loading (Edit)
- Show skeleton for form fields
- Disable inputs until loaded

### Saving
- Disable form
- Show loading on save button

### Error
- Show error toast
- Highlight failed field

### Success
- Navigate back
- Show success toast

## Visual Design

### Colors
- Background: Surface color
- Primary: `#2E7D32`
- Error: `#E53935`
- Required marker: Error color

### Typography
- Screen title: `headline-lg`
- Section header: `title-sm`
- Input text: `body-lg`
- Label: `label-md`

### Spacing
- Screen padding: 16px
- Field spacing: 16px vertical
- Section spacing: 24px
- Input padding: 12px vertical, 16px horizontal
