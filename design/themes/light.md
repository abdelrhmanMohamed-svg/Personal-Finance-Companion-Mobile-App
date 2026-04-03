# Light Theme Specification

**Task**: T005 - Create light theme specification

## Color Scheme

### Primary Colors
| Token | Light Mode | Usage |
|-------|------------|-------|
| `primary` | `#2E7D32` | Brand green, CTAs |
| `primary-hover` | `#1B5E20` | Pressed state |
| `primary-light` | `rgba(46, 125, 50, 0.1)` | Backgrounds |
| `on-primary` | `#FFFFFF` | Text on primary |

### Secondary Colors
| Token | Light Mode | Usage |
|-------|------------|-------|
| `secondary` | `#1565C0` | Links, secondary actions |
| `secondary-hover` | `#0D47A1` | Pressed state |
| `secondary-light` | `rgba(21, 101, 192, 0.1)` | Backgrounds |
| `on-secondary` | `#FFFFFF` | Text on secondary |

### Surface Colors
| Token | Light Mode | Usage |
|-------|------------|-------|
| `background` | `#FAFAFA` | Page background |
| `surface` | `#FFFFFF` | Cards, sheets |
| `surface-elevated` | `#FFFFFF` | Elevated surfaces |
| `surface-overlay` | `rgba(0, 0, 0, 0.5)` | Overlays |

### Text Colors
| Token | Light Mode | Usage |
|-------|------------|-------|
| `text-primary` | `#212121` | Headings, primary text |
| `text-secondary` | `#616161` | Body text |
| `text-tertiary` | `#9E9E9E` | Captions, hints |
| `text-disabled` | `rgba(0, 0, 0, 0.38)` | Disabled text |

### Border Colors
| Token | Light Mode | Usage |
|-------|------------|-------|
| `border` | `#E0E0E0` | Dividers, subtle borders |
| `border-focus` | `#2E7D32` | Focus ring |

### Semantic Colors
| Token | Light Mode | Usage |
|-------|------------|-------|
| `success` | `#43A047` | Positive states |
| `success-light` | `rgba(67, 160, 71, 0.1)` | Success backgrounds |
| `warning` | `#F9A825` | Warning states |
| `warning-light` | `rgba(249, 168, 37, 0.1)` | Warning backgrounds |
| `error` | `#E53935` | Error states |
| `error-light` | `rgba(229, 57, 53, 0.1)` | Error backgrounds |
| `info` | `#1E88E5` | Information |
| `info-light` | `rgba(30, 136, 229, 0.1)` | Info backgrounds |

## Typography (Light Theme)

Using the Manrope font family:
- **Display**: 57px / 45px / 36px
- **Headline**: 32px / 28px / 24px
- **Title**: 22px / 16px / 14px
- **Body**: 16px / 14px / 12px
- **Label**: 14px / 12px / 11px
- **Amount**: 34px / 24px / 18px

Text colors:
- `on-background`: `#212121`
- `on-surface`: `#212121`
- `on-surface-variant`: `#616161`

## Spacing (Light Theme)

Standard 4px base unit scale:
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
| 1 | `0 1px 2px rgba(0, 0, 0, 0.05)` | Subtle elevation |
| 2 | `0 2px 8px rgba(0, 0, 0, 0.08)` | Cards, buttons |
| 3 | `0 4px 16px rgba(0, 0, 0, 0.12)` | Floating elements |
| 4 | `0 8px 32px rgba(0, 0, 0, 0.16)` | Modals, sheets |

## Component Styles

### Button
- **Primary**: Green background, white text
- **Secondary**: White background, green border, green text
- **Text**: No background, green text

### Input
- **Background**: White
- **Border**: `#E0E0E0`
- **Focus Border**: `#2E7D32`
- **Text**: `#212121`
- **Placeholder**: `#9E9E9E`

### Card
- **Background**: White
- **Border Radius**: 12px
- **Shadow**: Level 2
- **Padding**: 16px

### Bottom Navigation
- **Background**: White
- **Shadow**: Level 1
- **Icon Active**: `#2E7D32`
- **Icon Inactive**: `#9E9E9E`
- **Label Active**: `#2E7D32`
- **Label Inactive**: `#757575`

## Usage

1. Use light theme by default on iOS/Android
2. Respect system preference when available
3. Provide manual toggle in settings
4. Smooth transition animations between themes
5. Use appropriate shadows for elevation hierarchy
