# Typography Scale Design

**Task**: T002 - Generate typography scale design for Personal Finance Companion

## Font Family

### Primary Font: Manrope
- **Usage**: All text throughout the app
- **Google Fonts URL**: https://fonts.google.com/specimen/Manrope
- **License**: Open Source (OFL)
- **Weights Available**: 200, 300, 400, 500, 600, 700, 800

## Typography Scale

### Display
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `display-lg` | 57px | 400 | 64px | -0.25px | Hero numbers (large balance) |
| `display-md` | 45px | 400 | 52px | 0px | Large totals |
| `display-sm` | 36px | 400 | 44px | 0px | Section headers |

### Headline
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `headline-lg` | 32px | 600 | 40px | 0px | Screen titles |
| `headline-md` | 28px | 600 | 36px | 0px | Section headers |
| `headline-sm` | 24px | 600 | 32px | 0px | Card titles |

### Title
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `title-lg` | 22px | 600 | 28px | 0px | List item titles |
| `title-md` | 16px | 600 | 24px | 0.15px | Subtitles |
| `title-sm` | 14px | 600 | 20px | 0.1px | Small titles |

### Body
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `body-lg` | 16px | 400 | 24px | 0.5px | Primary body text |
| `body-md` | 14px | 400 | 20px | 0.25px | Secondary body text |
| `body-sm` | 12px | 400 | 16px | 0.4px | Caption text |

### Label
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `label-lg` | 14px | 500 | 20px | 0.1px | Button text |
| `label-md` | 12px | 500 | 16px | 0.5px | Input labels |
| `label-sm` | 11px | 500 | 16px | 0.5px | Small labels |

### Number/Financial
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `amount-lg` | 34px | 700 | 42px | -0.5px | Account balance |
| `amount-md` | 24px | 700 | 32px | -0.25px | Transaction amounts |
| `amount-sm` | 18px | 600 | 24px | 0px | List amounts |

## Text Styles by Component

### Screen Title
- **Style**: `headline-lg`
- **Color**: `gray-900` (light) / `gray-100` (dark)
- **Alignment**: Left

### Section Header
- **Style**: `headline-md`
- **Color**: `gray-800` (light) / `gray-200` (dark)
- **Alignment**: Left

### Card Title
- **Style**: `headline-sm`
- **Color**: `gray-800` (light) / `gray-200` (dark)
- **Alignment**: Left

### Body Text
- **Style**: `body-md`
- **Color**: `gray-700` (light) / `gray-300` (dark)
- **Alignment**: Left

### Caption
- **Style**: `body-sm`
- **Color**: `gray-500` (light) / `gray-500` (dark)
- **Alignment**: Left

### Button Text
- **Style**: `label-lg`
- **Color**: White (primary) / Primary (secondary)
- **Alignment**: Center (uppercase optional)

### Input Label
- **Style**: `label-md`
- **Color**: `gray-600` (light) / `gray-400` (dark)
- **Alignment**: Left

### Amount (Income)
- **Style**: `amount-md` or `amount-sm`
- **Color**: Success green `#43A047`
- **Alignment**: Right

### Amount (Expense)
- **Style**: `amount-md` or `amount-sm`
- **Color**: Error red `#E53935`
- **Alignment**: Right

### Amount (Neutral)
- **Style**: `amount-md` or `amount-sm`
- **Color**: `gray-900` (light) / `gray-100` (dark)
- **Alignment**: Right

## Usage Guidelines

1. Use display sizes sparingly - only for hero content
2. Use headline sizes for screen titles and major sections
3. Use title sizes for cards and list items
4. Use body sizes for primary content
5. Use label sizes for buttons, inputs, and captions
6. Use amount styles for financial values
7. Maintain consistent line heights for readability
8. Use negative letter spacing for large display text
