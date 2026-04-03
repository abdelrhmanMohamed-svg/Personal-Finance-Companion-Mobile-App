# Navigation (Bottom Nav) Design

**Task**: T030 - Design Navigation

## Screen Overview

The bottom navigation provides access to the 5 main app screens.

## Layout Structure

### Position
- **Location**: Bottom of screen
- **Height**: 80px (including safe area for notched devices)
- **Z-Index**: Above content, below FAB

### Background
- **Color**: White (light) / `#1E1E1E` (dark)
- **Shadow**: `shadow-sm` (light mode only)
- **Border**: None

### Navigation Items

| Position | Label | Icon (Inactive) | Icon (Active) |
|----------|-------|-----------------|---------------|
| 1 | Home | Home outline | Home filled |
| 2 | Transactions | List outline | List filled |
| 3 | (FAB) | + (white) | - |
| 4 | Goals | Target outline | Target filled |
| 5 | Insights | Chart outline | Chart filled |

### Item Layout
- **Width**: 20% of screen width each (except FAB)
- **Icon Size**: 24px
- **Label Size**: `label-sm`
- **Spacing (Icon-Label)**: 4px
- **Padding**: 8px vertical

### Item Colors
- **Active**:
  - Icon: Primary green `#2E7D32`
  - Label: Primary green `#2E7D32`
- **Inactive**:
  - Icon: `#9E9E9E` (light) / `#757575` (dark)
  - Label: `#757575` (light) / `#757575` (dark)

### FAB (Floating Action Button)
- **Position**: Centered, above nav bar
- **Size**: 56x56px
- **Offset**: 28px above nav bar
- **Background**: Primary green `#2E7D32`
- **Icon**: Plus, 24px, white
- **Shadow**: Elevation 3
- **Border Radius**: Full (circular)

### States

#### Default
- Show inactive icons and labels

#### Active
- Show filled icon
- Primary color
- Slight scale (1.05x) animation

#### Pressed
- Ripple effect
- Background: Primary at 8% opacity

#### Disabled
- Not applicable (nav always active)

### Badge Support
- **Position**: Top-right of icon
- **Shape**: Circle, 18px diameter
- **Background**: Error red `#E53935`
- **Text**: White, centered
- **Max Value**: "99+"
- **Usage**: Transaction count notification

## Interactions

### Tap Navigation Item
- Navigate to corresponding screen
- Update active state

### Tap FAB
- Navigate to Add Transaction screen

### Swipe (Optional)
- Swipe left/right to switch tabs

### Long Press (Optional)
- Show tooltip with screen name

## Safe Area Handling

### iOS (Notched)
- Extend background to edges
- Content starts below safe area
- Nav sits at bottom, above home indicator

### Android
- Respect system navigation bar
- Content above nav bar

## Animation

### Tab Switch
- Fade transition between screens
- Duration: 200ms

### Active Indicator
- Scale up: 150ms ease-out
- Color change: 100ms

### FAB
- Scale on press: 0.95
- Shadow change: elevation 1 on press

## Visual Design

### Colors Summary
- Nav background: `#FFFFFF` (light) / `#1E1E1E` (dark)
- Active icon/text: `#2E7D32`
- Inactive icon/text: `#9E9E9E` / `#757575`
- FAB: `#2E7D32`
- Badge: `#E53935`

### Typography
- Labels: `label-sm`, 11px

### Spacing
- Nav height: 80px
- Item padding: 8px
- Icon-label gap: 4px

## Implementation Notes

- Use `BottomNavigationBar` widget
- Use `FloatingActionButton` positioned
- Implement `IndexedStack` for tab persistence
- Support `PageView` swipe if enabled
- Handle safe area with `SafeArea` widget
