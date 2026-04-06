# Data Model: Theme Management

**Feature**: Theme Management (Light & Dark Mode)

## Theme State

### ThemeModeState

Represents the current theme configuration.

| Field | Type | Description |
|-------|------|-------------|
| themeMode | ThemeMode | Current theme: light, dark, or system |
| systemThemeEnabled | bool | Whether system theme detection is active |

### ThemeMode Enum

Flutter's native enum with three values:

- `ThemeMode.light` - Light theme active
- `ThemeMode.dark` - Dark theme active  
- `ThemeMode.system` - Follows device system setting

## Validation Rules

- Theme mode must be a valid ThemeMode enum value
- System theme flag only relevant when themeMode is system (but can be toggled independently)
- Default state on first launch: themeMode = light, systemThemeEnabled = false

## State Transitions

```
Initial (no storage):
  → ThemeModeState(themeMode: light, systemThemeEnabled: false)

User toggles to dark:
  ThemeModeState(themeMode: light, ...) → ThemeModeState(themeMode: dark, ...)

User enables system theme:
  ThemeModeState(themeMode: light, systemThemeEnabled: false) → ThemeModeState(themeMode: system, systemThemeEnabled: true)

Storage corrupted / unreadable:
  → ThemeModeState(themeMode: light, systemThemeEnabled: false)
```

## Relationships

Theme state is a singleton - only one active theme mode at any time. No related entities required.

## Storage

Hydrated storage automatically serializes ThemeModeState to JSON:
```json
{
  "themeMode": "dark",
  "systemThemeEnabled": false
}
```

Storage key: `theme_cubit_state` (default by hydrated_bloc)