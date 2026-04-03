# Personal Finance Companion App - Project Plan

## Overview
This project is a mobile personal finance companion app built using Flutter and Dart.

The app helps users:
- Track daily transactions
- Monitor spending habits
- Manage simple budgets
- Build saving habits using streaks
- View insights about their financial behavior

This is not a banking app. It is a lightweight, user-friendly financial tracking tool designed for everyday use.

---

## Tech Stack

- Frontend: Flutter (Dart)
- State Management: Cubit (Bloc)
- Backend: Supabase (Auth + Database)
- Design: Google Stitch generated UI

---

## Architecture

The project follows a Feature-based + Clean Architecture hybrid structure.
lib/
├── core/
│ ├── theme/
│ ├── utils/
│ ├── services/
│
├── features/
│ ├── auth/
│ ├── transactions/
│ ├── dashboard/
│ ├── goals/
│ ├── insights/
│
├── shared/
│ ├── widgets/
│ ├── models/



Each feature contains:
data/
domain/
presentation/

State management:
- One Cubit per feature
- Clear separation between UI and business logic

---

## Phases Plan

---

### Phase 0: Product Definition

#### Objective
Define the product scope and user experience before development.

#### Deliverables
- User flows
- Screen list
- Navigation structure
- MVP scope definition

#### Spec Content
- User persona
- Core features
- App goals
- Navigation map
- Success criteria

---

### Phase 1: Project Setup and Architecture

#### Objective
Set up a clean and scalable project structure.

#### Deliverables
- Flutter project initialized
- Folder structure created
- Cubit setup
- Supabase integration configured
- Routing system implemented

#### Spec Content
- Architecture decisions
- Folder structure
- State management approach
- Environment configuration
- Dependency setup

---

### Phase 2.0: UI/UX Design Generation (Google Stitch)

Objective
Generate a complete and consistent UI/UX system using Google Stitch MCP.

Deliverables

Full design system (colors, typography, spacing)
Reusable UI components
All app screens (dashboard, transactions, add/edit, goals, insights)
UI states (loading, empty, error)

Spec Content

Design principles (simple, clean, mobile-first)
Stitch generation strategy (system + components + screens)
Design tokens definition
Component list
Screen structure
Responsiveness considerations
----
### Phase 2.1: UI Implementation (Flutter)

Objective
Implement the generated UI in Flutter using reusable components and ScreenUtil.

Deliverables

App theme (tokens applied)
Reusable widgets (buttons, inputs, cards)
Responsive UI using ScreenUtil
All screens built from components

Spec Content

Mapping design → Flutter
Component implementation
Layout rules
Responsive rules (ScreenUtil)
UI structure (feature-based)
---

### Phase 3: Authentication (Supabase)

#### Objective
Implement user authentication using Supabase.

#### Deliverables
- Signup screen
- Login screen
- Auth state handling
- Session persistence

#### Spec Content
- Auth flow
- Validation rules
- Error handling
- Cubit states
- Supabase auth integration

---

### Phase 4: Transactions Module (Core Feature)

#### Objective
Build the main transaction management system.

#### Deliverables
- Add transaction
- Edit transaction
- Delete transaction
- Transaction list view
- Filtering and search

#### Spec Content
- Transaction data model
- CRUD operations
- UI flows
- Cubit states
- Supabase database integration
- Edge cases (empty state, invalid input)

---

### Phase 5: Dashboard

#### Objective
Provide a clear overview of financial data.

#### Deliverables
- Current balance display
- Total income and expenses
- Visual charts (category or weekly)
- Quick summary cards

#### Spec Content
- Dashboard layout
- Data aggregation logic
- Chart types
- UI states (loading, empty, error)

---

### Phase 6: Goals Feature (Budget Tracker + Saving Streak)

#### Objective
Add engaging and meaningful product features.

#### Features Included
- Budget tracker per category or total
- Saving streak system (days without overspending)

#### Deliverables
- Budget setup UI
- Budget tracking logic
- Streak tracking system
- Alerts or indicators

#### Spec Content
- Goal data model
- Budget rules
- Streak calculation logic
- UI flows
- Cubit states
- Integration with transactions

---

### Phase 7: Insights Screen

#### Objective
Help users understand their financial behavior.

#### Deliverables
- Spending by category
- Weekly comparison
- Monthly trends
- Top spending category

#### Spec Content
- Analytics calculations
- Data visualization logic
- UI layout for insights
- Performance considerations

---

### Phase 8: UX and Polish

#### Objective
Improve the overall mobile experience.

#### Deliverables
- Loading states
- Empty states
- Error handling
- Smooth navigation
- Basic animations

#### Spec Content
- UX rules
- Interaction behavior
- State handling patterns
- Accessibility considerations

---

### Phase 9: Documentation and Final Review

#### Objective
Prepare the project for evaluation.

#### Deliverables
- README file
- Setup instructions
- Feature explanation
- Architecture explanation

#### Spec Content
- Project overview
- Installation steps
- Assumptions
- Known limitations

---

## Data Models

### Transaction
id
amount
type (income | expense)
category
date
note
user_id


### Budget
id
user_id
category (optional)
limit_amount
current_spent
period (monthly)


### Streak

id
user_id
current_streak
last_updated

---

## Key Features Summary

- Authentication using Supabase
- Transaction tracking (CRUD)
- Dashboard with financial overview
- Budget tracking system
- Saving streak system
- Insights and analytics
- Clean architecture with Cubit

---


## Success Criteria

- All core features are functional
- UI is clean and mobile-friendly
- State management is clear and organized
- Data handling is consistent
- Code is readable and maintainable
- The app feels like a real product, not a demo

---