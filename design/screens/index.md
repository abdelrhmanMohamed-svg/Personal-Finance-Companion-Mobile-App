# Screen Inventory and Navigation Flow

**Task**: T031 - Create screen inventory and navigation flow

## Screen Inventory

| ID | Screen | Description | File |
|----|--------|-------------|------|
| S1 | Dashboard | Main home with balance and recent transactions | `dashboard.md` |
| S2 | Transactions List | Full transaction history | `transactions-list.md` |
| S3 | Transaction Form | Add/Edit transaction | `transaction-form.md` |
| S4 | Goals | Savings goals management | `goals.md` |
| S5 | Insights | Financial analytics | `insights.md` |

## Navigation Flow

```
┌─────────────────────────────────────────┐
│              Bottom Nav                  │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │Dashboard│ │Goals    │ │Insights │   │
│  └────┬────┘ └────┬────┘ └────┬────┘   │
│       │           │           │         │
│       ▼           ▼           ▼         │
│  [Recent]    [Goal Detail]  [Charts]    │
│  [Trans]     [Add Goal]      [Tips]      │
│       │           │                       │
│       ▼           ▼                       │
│  [Transaction]  [Edit Goal]              │
│  [Form]                                    │
│                                         │
│        ┌─────────────┐                   │
│        │   FAB (+)   │                   │
│        │  Add Trans  │                   │
│        └─────────────┘                   │
│                                         │
└─────────────────────────────────────────┘
```

## Navigation Map

### Dashboard (Home)
- → Transactions List: Tap "See All"
- → Transaction Detail: Tap transaction
- → Add Transaction: Tap FAB
- → Goals: Tap Goals nav
- → Insights: Tap Insights nav

### Transactions List
- → Transaction Detail: Tap transaction
- → Transaction Form (Edit): Long press → Edit
- → Transaction Form (Add): Tap FAB
- → Filter/Search: Tap icons

### Transaction Form (Add/Edit)
- → Dashboard/Transactions: Save/Cancel
- → Category Picker: Tap category field

### Goals
- → Goal Detail: Tap goal card
- → Add Goal: Tap FAB or Add button
- → Edit Goal: Long press → Edit

### Insights
- (Static content, no deep navigation)

## Route Structure

```
/                     → Dashboard
/transactions         → Transactions List
/transactions/:id      → Transaction Detail
/transactions/add      → Add Transaction
/transactions/:id/edit → Edit Transaction
/goals                 → Goals List
/goals/add             → Add Goal
/goals/:id             → Goal Detail
/goals/:id/edit        → Edit Goal
/insights              → Insights
```

## Data Flow

### Dashboard
- Fetches: Balance, Recent Transactions, Quick Stats
- Refreshes on pull-to-refresh

### Transactions List
- Fetches: Paginated transactions
- Filters: Local + server-side
- Search: Server-side

### Transaction Form
- Validates: Client-side
- Saves: Local + sync to server
- Updates: Existing transaction

### Goals
- Fetches: Goals with progress
- CRUD: Create, Read, Update, Delete

### Insights
- Fetches: Aggregated data
- Time periods: Week, Month, Year

## Shared Components

All screens use:
- App Bar (top)
- Bottom Navigation (main nav)
- Loading States (skeleton)
- Error States (retry)
- Empty States (CTA)

## Screen States

### Common States
- Loading
- Loaded
- Empty
- Error

### Screen-Specific
- Dashboard: Balance loading
- Transactions: Filtering, Searching
- Form: Validating, Saving
- Goals: Progress calculation
- Insights: Chart rendering

## Files Reference

```
design/
├── screens/
│   ├── dashboard.md       # Dashboard screen
│   ├── transactions-list.md # Transactions list
│   ├── transaction-form.md # Add/Edit transaction
│   ├── goals.md           # Goals screen
│   ├── insights.md        # Insights screen
│   ├── navigation.md      # Bottom navigation
│   └── index.md           # This file
└── components/
    ├── cards.md           # Card components
    ├── inputs.md          # Input components
    ├── feedback.md        # Loading/empty/error
    └── navigation.md      # Nav components
```
