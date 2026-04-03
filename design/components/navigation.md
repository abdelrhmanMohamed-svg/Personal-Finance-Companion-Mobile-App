# Navigation Components Design

**Task**: T012 - Design navigation components

## Bottom Navigation Bar

### Structure
- **Height**: 80px (including safe area)
- **Background**: White (light) / `#1E1E1E` (dark)
- **Shadow**: `shadow-sm` (light) / none (dark)
- **Border**: None (use shadow for separation)

### Navigation Items (5 items)
1. **Dashboard** (Home)
   - Icon: Home outline (inactive) / Home filled (active)
   - Label: "Home"

2. **Transactions**
   - Icon: List outline (inactive) / List filled (active)
   - Label: "Transactions"

3. **Add** (FAB in center)
   - Icon: Plus, 24px, white
   - Size: 56x56px
   - Background: Primary green
   - Elevation: 3
   - Position: Raised above nav bar

4. **Goals**
   - Icon: Target/Goal outline (inactive) / Target filled (active)
   - Label: "Goals"

5. **Insights**
   - Icon: Chart outline (inactive) / Chart filled (active)
   - Label: "Insights"

### Item Layout
- **Width**: Equal distribution (20% each)
- **Icon Size**: 24px
- **Label**: `label-sm`, below icon
- **Spacing**: 4px between icon and label
- **Active Color**: Primary green
- **Inactive Color**: `#9E9E9E` (light) / `#757575` (dark)

### States
- **Active**: Primary color, filled icon
- **Inactive**: Gray color, outlined icon
- **Pressed**: Ripple effect with primary at 8% opacity

### Badge Support
- **Transaction Count**: Red circle, top-right of icon
- **Size**: 18px circle
- **Text**: White, `label-sm`, centered
- **Max**: "99+"

## Tab Bar (Secondary Navigation)

### Structure
- **Height**: 48px
- **Background**: Surface color
- **Border**: None or bottom border (subtle)

### Tab Items
- **Layout**: Horizontal scroll or fit
- **Padding**: 16px horizontal per item
- **Height**: Full height
- **Indicator**: 2px bottom border, primary green

### Tab Content
- **Label**: `label-lg`
- **Active**: Primary color
- **Inactive**: Secondary text color

### Usage
- Filters (This week, This month, Custom)
- View modes (List, Calendar)

## App Bar (Top Navigation)

### Structure
- **Height**: 56px (+ safe area)
- **Background**: Surface color
- **Shadow**: None or `shadow-sm`

### Left Section
- **Back Button**: Arrow left icon, 24px, primary action
- **Menu Button**: Hamburger icon (drawer)

### Center Section
- **Title**: `headline-sm`, centered
- **Subtitle**: Optional, `body-sm`, below title

### Right Section
- **Actions**: Icon buttons (search, filter, more)
- **Spacing**: 8px between actions
- **Avatar**: Optional, 32px, rightmost

### Search Bar (Expandable)
- **Hidden**: Collapsed to icon
- **Expanded**: Full width input
- **Close Button**: X icon to collapse

## Drawer Navigation

### Structure
- **Width**: 280px
- **Background**: Surface color
- **Header**: User info, 160px height

### Menu Items
- **Height**: 48px
- **Padding**: 16px horizontal
- **Icon**: 24px, left
- **Label**: `body-lg`, after icon
- **Trailing**: Optional badge or chevron

### Sections
- **Divider**: Between sections
- **Section Title**: `label-md`, uppercase, padding

## Usage Guidelines

1. Use bottom navigation for main app sections
2. Keep navigation simple - max 5 items
3. Use FAB for primary action (add transaction)
4. Provide clear active/inactive states
5. Use badges for notifications/counts
6. Ensure 48px minimum touch targets
7. Consider keyboard accessibility
8. Support gestures (swipe to navigate)
