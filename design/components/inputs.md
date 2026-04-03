# Input Components Design

**Task**: T009 - Design input components

## Text Input Field

### Default State
- **Height**: 56px
- **Background**: White (light) / `#2C2C2C` (dark)
- **Border**: 1px solid `#E0E0E0` (light) / `#424242` (dark)
- **Border Radius**: 8px
- **Padding**: 12px vertical, 16px horizontal
- **Label**: Floats above on focus/filled, `label-md` style
- **Placeholder**: `#9E9E9E` (light) / `#757575` (dark)
- **Text**: `body-md` style, `#212121` (light) / `#FAFAFA` (dark)

### Focus State
- **Border**: 2px solid `#2E7D32` (primary green)
- **Label**: Floats above, primary green color

### Filled State
- **Label**: Floats above input
- **Background**: Slightly tinted with primary at 5% opacity

### Error State
- **Border**: 2px solid `#E53935`
- **Error Text**: Below input, `body-sm`, error color
- **Helper Text**: Replaced with error message

### Disabled State
- **Background**: `#F5F5F5` (light) / `#1A1A1A` (dark)
- **Border**: 1px solid `#E0E0E0` (light) / `#333333` (dark)
- **Text**: At 38% opacity
- **Label**: At 38% opacity

## Input Types

### Text Input
- Single line text entry
- Clear button when filled
- Character counter (optional)

### Number Input
- Numeric keyboard
- Currency formatting
- Decimal support for amounts

### Amount Input
- Currency symbol prefix ($)
- Thousands separator
- Two decimal places
- Right-aligned text

### Date Input
- Date picker integration
- Display format: MM/DD/YYYY
- Storage format: ISO 8601

### Multi-line Input (TextArea)
- **Min Height**: 120px
- **Max Height**: 200px (scrollable)
- **Resize**: None (fixed height)

## Selection Components

### Dropdown/Select
- **Trigger Height**: 56px
- **Border**: Same as text input
- **Icon**: Chevron down, 24px, right-aligned
- **Dropdown**: Max height 280px, scrollable
- **Option Height**: 48px
- **States**:
  - Default: Standard border
  - Focus: Primary border
  - Selected: Checkmark icon, primary color

### Date Picker
- **Trigger**: Same as text input
- **Picker**: Calendar modal
- **Month View**: 7-column grid
- **Selected**: Primary green background
- **Today**: Outlined circle
- **Header**: Month/Year with navigation arrows

### Time Picker
- **Trigger**: Same as text input  
- **Picker**: Scrollable wheel picker
- **Format**: 12-hour with AM/PM
- **Hour/Minute**: Separate wheels

## Search Input
- **Leading Icon**: Search icon, 24px
- **Trailing Icon**: Clear (when filled)
- **Height**: 48px (compact)
- **Border Radius**: 24px (pill shape)
- **Placeholder**: "Search transactions..."

## Usage Guidelines

1. Always show labels (floating or static)
2. Show helper text for complex inputs
3. Use error states for validation failures
4. Disable inputs that are not available
5. Use appropriate keyboard types
6. Format currency/date inputs automatically
7. Ensure 56px height for main inputs
8. Provide clear button for text inputs
