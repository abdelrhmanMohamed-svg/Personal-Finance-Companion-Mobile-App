# Spacing System Design

**Task**: T003 - Generate spacing system design for Personal Finance Companion

## Base Unit

- **Base Unit**: 4px
- **Scale**: Multiples of 4 (4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96)

## Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `spacing-0` | 0px | No spacing |
| `spacing-1` | 4px | Tight inline spacing |
| `spacing-2` | 8px | Compact elements |
| `spacing-3` | 12px | Default inline spacing |
| `spacing-4` | 16px | Standard spacing |
| `spacing-5` | 20px | Comfortable spacing |
| `spacing-6` | 24px | Section spacing |
| `spacing-8` | 32px | Large section spacing |
| `spacing-10` | 40px | Extra large spacing |
| `spacing-12` | 48px | Section gaps |
| `spacing-16` | 64px | Major section gaps |
| `spacing-20` | 80px | Page margins (vertical) |
| `spacing-24` | 96px | Full height gaps |

## Spacing by Component

### Screen Padding
| Token | Value | Usage |
|-------|-------|-------|
| `screen-padding-horizontal` | 16px | Left/right padding |
| `screen-padding-vertical` | 16px | Top/bottom padding |
| `screen-padding-safe` | 16px | Safe area insets |

### Card Padding
| Token | Value | Usage |
|-------|-------|-------|
| `card-padding` | 16px | Default card padding |
| `card-padding-compact` | 12px | Compact card padding |
| `card-padding-spacious` | 24px | Spacious card padding |

### List Item Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `list-item-padding-vertical` | 12px | Vertical padding |
| `list-item-padding-horizontal` | 16px | Horizontal padding |
| `list-item-spacing` | 0px | Between list items (divider) |
| `list-section-spacing` | 24px | Between sections |

### Button Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `button-padding-vertical` | 12px | Vertical padding |
| `button-padding-horizontal` | 24px | Horizontal padding |
| `button-gap` | 8px | Between buttons |
| `button-min-height` | 48px | Minimum touch target |

### Input Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `input-padding-vertical` | 12px | Vertical padding |
| `input-padding-horizontal` | 16px | Horizontal padding |
| `input-gap` | 8px | Between label and input |
| `input-min-height` | 56px | Input field height |

### Icon Spacing
| Token | Value | Usage |
|-------|-------|-------|
| `icon-size-xs` | 16px | Extra small icons |
| `icon-size-sm` | 20px | Small icons |
| `icon-size-md` | 24px | Medium icons |
| `icon-size-lg` | 32px | Large icons |
| `icon-gap` | 8px | Icon to text spacing |

### Navigation
| Token | Value | Usage |
|-------|-------|-------|
| `bottom-nav-height` | 80px | Bottom navigation height |
| `bottom-nav-padding` | 8px | Navigation item padding |
| `tab-bar-height` | 48px | Tab bar height |

## Layout Spacing

### Grid System
| Token | Value | Usage |
|-------|-------|-------|
| `grid-gutter` | 16px | Grid column gap |
| `grid-margin` | 16px | Grid outer margin |
| `grid-columns` | 4 | Number of columns (mobile) |

### Transaction List
| Token | Value | Usage |
|-------|-------|-------|
| `transaction-item-height` | 72px | Transaction row height |
| `transaction-icon-size` | 40px | Category icon container |
| `transaction-date-spacing` | 8px | Date to first item |

### Dashboard Cards
| Token | Value | Usage |
|-------|-------|-------|
| `card-border-radius` | 12px | Card corner radius |
| `card-shadow` | `0 2px 8px rgba(0, 0, 0, 0.08)` | Card shadow |
| `card-gap` | 16px | Space between cards |

## Responsive Adjustments

### Small Devices (< 360px)
- Reduce all spacing by 25%
- Use `spacing-3` instead of `spacing-4`
- Use `spacing-4` instead of `spacing-6`

### Standard Devices (360px - 414px)
- Use default spacing scale

### Large Devices (> 414px)
- Use spacing scale with max of 24px
- Increase card padding to 24px
- Increase screen padding to 20px

## Usage Guidelines

1. Use spacing-4 (16px) as the default spacing
2. Use spacing-2 (8px) for tight, related elements
3. Use spacing-6 (24px) for visual separation
4. Use spacing-8 (32px) for major sections
5. Always ensure 48px minimum touch targets
6. Account for safe areas on notched devices
7. Use consistent spacing to create visual rhythm
