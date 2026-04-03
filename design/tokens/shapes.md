# Shape Tokens Design

**Task**: T004 - Generate shape tokens design for Personal Finance Companion

## Corner Radius Scale

| Token | Value | Usage |
|-------|-------|-------|
| `radius-none` | 0px | No rounding |
| `radius-sm` | 4px | Small elements, chips |
| `radius-md` | 8px | Buttons, inputs |
| `radius-lg` | 12px | Cards, containers |
| `radius-xl` | 16px | Large cards, modals |
| `radius-2xl` | 24px | Bottom sheets |
| `radius-full` | 9999px | Circular elements |

## Component Shapes

### Buttons
| Token | Value | Usage |
|-------|-------|-------|
| `button-radius` | 8px | Primary/Secondary buttons |
| `button-radius-full` | 24px | Pill buttons |
| `button-radius-sm` | 4px | Small buttons |

### Cards
| Token | Value | Usage |
|-------|-------|-------|
| `card-radius` | 12px | Standard cards |
| `card-radius-lg` | 16px | Elevated cards |
| `card-radius-sm` | 8px | Compact cards |

### Inputs
| Token | Value | Usage |
|-------|-------|-------|
| `input-radius` | 8px | Text inputs |
| `input-radius-sm` | 4px | Compact inputs |
| `chip-radius` | 8px | Chips, tags |

### Navigation
| Token | Value | Usage |
|-------|-------|-------|
| `nav-item-radius` | 12px | Nav item background |
| `bottom-sheet-radius` | 24px | Bottom sheet top |
| `modal-radius` | 16px | Modal dialogs |

### Avatars & Icons
| Token | Value | Usage |
|-------|-------|-------|
| `avatar-radius-sm` | 20px | Small avatar |
| `avatar-radius-md` | 24px | Medium avatar |
| `avatar-radius-lg` | 32px | Large avatar |
| `avatar-radius-full` | 9999px | Circular avatar |
| `icon-container-radius` | 8px | Category icon background |

### Transaction Items
| Token | Value | Usage |
|-------|-----|-------|
| `transaction-item-radius` | 0px | List item (use dividers) |
| `transaction-icon-radius` | 8px | Category icon circle |
| `amount-badge-radius` | 4px | Amount pill |

## Elevation & Shadows

### Shadow Scale
| Token | Value | Usage |
|-------|-------|-------|
| `shadow-none` | none | No shadow |
| `shadow-sm` | `0 1px 2px rgba(0, 0, 0, 0.05)` | Subtle elevation |
| `shadow-md` | `0 2px 8px rgba(0, 0, 0, 0.08)` | Cards |
| `shadow-lg` | `0 4px 16px rgba(0, 0, 0, 0.12)` | Elevated cards |
| `shadow-xl` | `0 8px 32px rgba(0, 0, 0, 0.16)` | Modals, bottom sheets |

### Shadow by Component
| Token | Shadow | Usage |
|-------|--------|-------|
| `card-shadow` | `shadow-md` | Transaction cards |
| `elevated-shadow` | `shadow-lg` | Floating elements |
| `modal-shadow` | `shadow-xl` | Modals |
| `nav-shadow` | `shadow-sm` | Bottom navigation |

## Border Widths

| Token | Value | Usage |
|-------|-------|-------|
| `border-width-none` | 0px | No border |
| `border-width-sm` | 1px | Subtle borders |
| `border-width-md` | 2px | Focus states |
| `border-width-lg` | 4px | Active states |

## Usage Guidelines

1. Use `radius-lg` (12px) as default for cards
2. Use `radius-md` (8px) for interactive elements
3. Use `radius-full` (9999px) for pills and avatars
4. Use shadows sparingly - prefer elevation for hierarchy
5. Match border radius to component size
6. Use consistent shapes across similar components
7. Consider rounded corners for friendly, approachable feel
