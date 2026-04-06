# Shared Component Registry

This registry tracks reusable components extracted from features.

## Format

| Field | Description |
|-------|--------------|
| Name | Component name |
| Location | File path in lib/shared/ or lib/core/ |
| Used By | Features using this component |
| Description | Component purpose |

## Components

| Name | Location | Used By | Description |
|------|----------|---------|-------------|
| EmptyStateWidget | lib/shared/widgets/ | dashboard, transactions, insights | Reusable empty state with icon, title, message, action |
| ErrorStateWidget | lib/shared/widgets/ | dashboard, transactions, insights | Reusable error state with retry action |

## Adding New Components

1. Identify duplicate pattern during code review
2. Follow extraction process in `docs/shared-component-process.md`
3. Add entry to this registry
4. Update consumers to use shared component

## Maintenance

- Review quarterly for unused components
- Remove entries if component is deprecated
- Update "Used By" when features adopt shared components
