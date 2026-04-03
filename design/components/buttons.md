# Button Components Design

**Task**: T008 - Design button components

## Button Variants

### Primary Button
- **Background**: Primary green `#2E7D32`
- **Text Color**: White `#FFFFFF`
- **Height**: 48px minimum
- **Padding**: 12px vertical, 24px horizontal
- **Border Radius**: 8px
- **States**:
  - Default: `#2E7D32` background
  - Hover: `#1B5E20` background
  - Pressed: `#1B5E20` with slight scale (0.98)
  - Disabled: `rgba(46, 125, 50, 0.38)` background, white text at 38% opacity
  - Loading: Spinner icon replaces text

### Secondary Button
- **Background**: Transparent
- **Border**: 1.5px solid `#2E7D32`
- **Text Color**: `#2E7D32`
- **Height**: 48px minimum
- **Padding**: 12px vertical, 24px horizontal
- **Border Radius**: 8px
- **States**:
  - Default: Transparent bg, green border
  - Hover: `rgba(46, 125, 50, 0.08)` background
  - Pressed: `rgba(46, 125, 50, 0.12)` background
  - Disabled: Border at 38% opacity, text at 38% opacity

### Text Button
- **Background**: Transparent
- **Text Color**: `#2E7D32`
- **Height**: 48px minimum (touch target)
- **Padding**: 12px vertical, 16px horizontal
- **States**:
  - Default: Transparent
  - Hover: `rgba(46, 125, 50, 0.08)` background
  - Pressed: `rgba(46, 125, 50, 0.12)` background
  - Disabled: Text at 38% opacity

### Icon Button
- **Size**: 48x48px (touch target)
- **Icon Size**: 24px
- **Border Radius**: Full (circular) or 8px
- **States**:
  - Default: Transparent
  - Hover: `rgba(0, 0, 0, 0.04)` (light) / `rgba(255, 255, 255, 0.08)` (dark)
  - Pressed: `rgba(0, 0, 0, 0.08)` (light) / `rgba(255, 255, 255, 0.16)` (dark)

## Button Sizes

| Size | Height | Padding (H) | Font | Icon Size |
|------|--------|-------------|------|-----------|
| Small | 36px | 16px | `label-md` | 16px |
| Medium | 48px | 24px | `label-lg` | 24px |
| Large | 56px | 32px | `title-sm` | 24px |

## Button Styles

### Default (Filled)
- Primary action buttons
- Most prominent on screen
- Green background

### Outlined
- Secondary actions
- Alternative to filled
- Green border, transparent bg

### Text
- Tertiary actions
- Least prominent
- No background or border

### FAB (Floating Action Button)
- **Size**: 56x56px (standard), 40x40px (mini)
- **Background**: Primary green
- **Icon**: White, 24px
- **Shadow**: Elevation 3
- **Position**: Bottom right, 16px from edges
- **States**:
  - Default: Elevation 3
  - Pressed: Elevation 1, slight scale

## Usage Guidelines

1. Use Primary button for main CTA
2. Use Secondary button for alternative actions
3. Use Text button for tertiary actions (cancel, skip)
4. Use FAB for adding new transactions
5. Ensure 48px minimum touch target
6. Use loading state for async actions
7. Always provide visual feedback on tap
