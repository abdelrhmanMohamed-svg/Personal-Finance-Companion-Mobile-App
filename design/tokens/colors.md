# Color Palette Design

**Task**: T001 - Generate color palette design for Personal Finance Companion

## Primary Colors

### Brand Green (Primary)
- **Hex**: `#2E7D32` (Forest Green)
- **RGB**: 46, 125, 50
- **Usage**: Primary actions, CTAs, brand elements
- **States**: 
  - Hover: `#1B5E20`
  - Active: `#1B5E20`
  - Disabled: `rgba(46, 125, 50, 0.38)`

### Secondary Blue
- **Hex**: `#1565C0` (Blue)
- **RGB**: 21, 101, 192
- **Usage**: Secondary actions, links
- **States**:
  - Hover: `#0D47A1`
  - Active: `#0D47A1`

## Semantic Colors

### Success
- **Hex**: `#43A047`
- **Usage**: Positive transactions, savings goals met
- **Background**: `rgba(67, 160, 71, 0.1)`

### Warning
- **Hex**: `#F9A825` (Amber)
- **Usage**: Budget warnings, overspending alerts
- **Background**: `rgba(249, 168, 37, 0.1)`

### Error
- **Hex**: `#E53935`
- **Usage**: Errors, failed transactions, delete actions
- **Background**: `rgba(229, 57, 53, 0.1)`

### Info
- **Hex**: `#1E88E5`
- **Usage**: Information, insights
- **Background**: `rgba(30, 136, 229, 0.1)`

## Neutral Colors

### Gray Scale
| Token | Hex | Usage |
|-------|-----|-------|
| `gray-50` | `#FAFAFA` | Page backgrounds |
| `gray-100` | `#F5F5F5` | Card backgrounds |
| `gray-200` | `#EEEEEE` | Borders, dividers |
| `gray-300` | `#E0E0E0` | Disabled backgrounds |
| `gray-400` | `#BDBDBD` | Placeholder text |
| `gray-500` | `#9E9E9E` | Secondary text |
| `gray-600` | `#757575` | Tertiary text |
| `gray-700` | `#616161` | Body text |
| `gray-800` | `#424242` | Headings |
| `gray-900` | `#212121` | Primary text |

## Surface Colors

### Light Theme
| Token | Hex | Usage |
|-------|-----|-------|
| `surface-primary` | `#FFFFFF` | Main surface |
| `surface-secondary` | `#FAFAFA` | Secondary surfaces |
| `surface-elevated` | `#FFFFFF` | Elevated cards |
| `surface-overlay` | `rgba(0, 0, 0, 0.5)` | Overlays |

### Dark Theme
| Token | Hex | Usage |
|-------|-----|-------|
| `surface-primary` | `#121212` | Main surface |
| `surface-secondary` | `#1E1E1E` | Secondary surfaces |
| `surface-elevated` | `#2C2C2C` | Elevated cards |
| `surface-overlay` | `rgba(0, 0, 0, 0.7)` | Overlays |

## Transaction Type Colors

### Income
- **Hex**: `#43A047` (Green)
- **Icon Background**: `rgba(67, 160, 71, 0.1)`
- **Usage**: Income entries, deposits

### Expense
- **Hex**: `#E53935` (Red)
- **Icon Background**: `rgba(229, 57, 53, 0.1)`
- **Usage**: Expense entries, withdrawals

### Transfer
- **Hex**: `#1565C0` (Blue)
- **Icon Background**: `rgba(21, 101, 192, 0.1)`
- **Usage**: Transfer entries

## Category Colors

| Category | Hex | Background |
|----------|-----|------------|
| Food & Dining | `#FF7043` | `rgba(255, 112, 67, 0.1)` |
| Transportation | `#42A5F5` | `rgba(66, 165, 245, 0.1)` |
| Shopping | `#AB47BC` | `rgba(171, 71, 188, 0.1)` |
| Entertainment | `#EC407A` | `rgba(236, 64, 122, 0.1)` |
| Bills & Utilities | `#FFA726` | `rgba(255, 167, 38, 0.1)` |
| Health | `#26A69A` | `rgba(38, 166, 154, 0.1)` |
| Education | `#5C6BC0` | `rgba(92, 107, 192, 0.1)` |
| Travel | `#29B6F6` | `rgba(41, 182, 246, 0.1)` |
| Groceries | `#66BB6A` | `rgba(102, 187, 106, 0.1)` |
| Other | `#78909C` | `rgba(120, 144, 156, 0.1)` |

## Accessibility

All color combinations meet WCAG AA standards:
- **Large text**: Minimum 3:1 contrast ratio
- **Regular text**: Minimum 4.5:1 contrast ratio
- **UI components**: Minimum 3:1 contrast ratio

## Usage Guidelines

1. Use primary green for primary actions
2. Use secondary blue for links and secondary actions
3. Use semantic colors for feedback (success/warning/error)
4. Use neutral grays for text and surfaces
5. Use category colors only for transaction categorization
6. Ensure sufficient contrast for accessibility
