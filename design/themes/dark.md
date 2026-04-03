# Dark Theme Specification

**Task**: T006 - Create dark theme specification

## Color Scheme

### Primary Colors
| Token | Dark Mode | Usage |
|-------|-----------|-------|
| `primary` | `#66BB6A` | Brand green (lighter for dark bg) |
| `primary-hover` | `#81C784` | Pressed state |
| `primary-light` | `rgba(102, 187, 106, 0.15)` | Backgrounds |
| `on-primary` | `#1B5E20` | Text on primary (dark green) |

### Secondary Colors
| Token | Dark Mode | Usage |
|-------|-----------|-------|
| `secondary` | `#42A5F5` | Links, secondary actions |
| `secondary-hover` | `#64B5F6` | Pressed state |
| `secondary-light` | `rgba(66, 165, 245, 0.15)` | Backgrounds |
| `on-secondary` | `#0D47A1` | Text on secondary |

### Surface Colors
| Token | Dark Mode | Usage |
|-------|-----------|-------|
| `background` | `#121212` | Page background |
| `surface` | `#1E1E1E` | Cards, sheets |
| `surface-elevated` | `#2C2C2C` | Elevated surfaces |
| `surface-overlay` | `rgba(0, 0, 0, 0.7)` | Overlays |

### Text Colors
| Token | Dark Mode | Usage |
|-------|-----------|-------|
| `text-primary` | `#FAFAFA` | Headings, primary text |
| `text-secondary` | `#B0B0B0` | Body text |
| `text-tertiary` | `#757575` | Captions, hints |
| `text-disabled` | `rgba(255, 255, 255, 0.38)` | Disabled text |

### Border Colors
| Token | Dark Mode | Usage |
|-------|-----------|-------|
| `border` | `#424242` | Dividers, subtle borders |
| `border-focus` | `#66BB6A` | Focus ring |

### Semantic Colors
| Token | Dark Mode | Usage |
|-------|-----------|-------|
| `success` | `#66BB6A` | Positive states |
| `success-light` | `rgba(102, 187, 106, 0.15)` | Success backgrounds |
| `warning` | `#FFCA28` | Warning states |
| `warning-light` | `rgba(255, 202, 40, 0.15)` | Warning backgrounds |
| `error` | `#EF5350` | Error states |
| `error-light` | `rgba(239, 83, 80, 0.15)` | Error backgrounds |
| `info` | `#42A5F5` | Information |
| `info-light` | `rgba(66, 165, 245, 0.15)` | Info backgrounds |

## Typography (Dark Theme)

Using the Manrope font family:
- **Display**: 57px / 45px / 36px
- **Headline**: 32px / 28px / 24px
- **Title**: 22px / 16px / 14px
- **Body**: 16px / 14px / 12px
- **Label**: 14px / 12px / 11px
- **Amount**: 34px / 24px / 18px

Text colors:
- `on-background`: `#FAFAFA`
- `on-surface`: `#FAFAFA`
- `on-surface-variant`: `#B0B0B0`

## Spacing (Dark Theme)

Standard 4px base unit scale (same as light):
- `spacing-1`: 4px
- `spacing-2`: 8px
- `spacing-3`: 12px
- `spacing-4`: 16px
- `spacing-5`: 20px
- `spacing-6`: 24px
- `spacing-8`: 32px

## Elevation & Shadows

| Level | Shadow | Usage |
|-------|--------|-------|
| 0 | none | Flat surfaces |
| 1 | `0 1px 2px rgba(0, 0, 0, 0.3)` | Subtle elevation |
| 2 | `0 2px 8px rgba(0, 0, 0, 0.4)` | Cards, buttons |
| 3 | `0 4px 16px rgba(0, 0, 0, 0.5)` | Floating elements |
| 4 | `0 8px 32px rgba(0, 0, 0, 0.6)` | Modals, sheets |

## Component Styles

### Button
- **Primary**: Lighter green background (`#66BB6A`), dark text (`#1B5E20`)
- **Secondary**: Dark surface background, lighter green border/text
- **Text**: No background, lighter green text

### Input
- **Background**: `#2C2C2C`
- **Border**: `#424242`
- **Focus Border**: `#66BB6A`
- **Text**: `#FAFAFA`
- **Placeholder**: `#757575`

### Card
- **Background**: `#1E1E1E`
- **Border Radius**: 12px
- **Shadow**: Level 2 (adjusted for dark)
- **Padding**: 16px

### Bottom Navigation
- **Background**: `#1E1E1E`
- **Shadow**: Level 1 (subtle)
- **Icon Active**: `#66BB6A`
- **Icon Inactive**: `#757575`
- **Label Active**: `#66BB6A`
- **Label Inactive**: `#757575`

## Contrast Requirements

- Text on background: Minimum 4.5:1 ratio
- Large text on background: Minimum 3:1 ratio
- UI components: Minimum 3:1 ratio
- Adjusted colors ensure WCAG AA compliance in dark mode

## Usage

1. Use dark theme when system preference is dark
2. Provide manual toggle in settings
3. Smooth transition animations between themes
4. Maintain consistent elevation hierarchy
5. Ensure sufficient contrast ratios
