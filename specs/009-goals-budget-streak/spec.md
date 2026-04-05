# Feature Specification: Goals Feature (Budget Tracker + Savings Goals + Saving Streak)

**Feature Branch**: `009-goals-budget-streak`  
**Created**: 2026-04-05  
**Status**: Draft  
**Input**: User description: "make a spec for ### Phase 6: Goals Feature (Budget Tracker + Saving Streak) you will find in C:\rich_Sonic\personal_finance_companion_mobile_app\plan.md"

## Clarifications

### Session 2026-04-05

- Q: What happens when the user sets a budget of zero or negative amount? → A: Budget must be greater than zero (positive amounts only)
- Q: What happens when the streak is broken - is there any grace period or does it reset immediately? → A: No grace period, streak resets immediately when budget is exceeded
- Q: How does the system handle budget setup if the user has no transaction history yet? → A: Users can set budgets freely; initial category suggestions come from app defaults
- Q: What type of goals should users be able to set? → A: Both budgets (spending limits) and open-ended savings goals (target amounts without deadlines)

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Set and Track Monthly Budget (Priority: P1)

As a user, I want to set a monthly spending budget so that I can control my expenses and avoid overspending.

**Why this priority**: Budget tracking is the core of this phase - it provides immediate value by helping users manage their finances and is the foundation for streak tracking.

**Independent Test**: Can be tested by setting a budget, logging expenses, and verifying budget progress updates correctly.

**Acceptance Scenarios**:

1. **Given** the user has no budget set, **When** they create a monthly budget with a specific limit, **Then** the budget is saved and displayed as active
2. **Given** a budget is active, **When** the user adds expenses throughout the month, **Then** the budget progress updates to show remaining amount
3. **Given** the budget is at 80% spent, **When** the user views the budget, **Then** they see a warning indicator
4. **Given** the budget is exceeded, **When** the user views the budget, **Then** they see an alert showing overspending

---

### User Story 2 - Category-Specific Budget (Priority: P2)

As a user, I want to set budget limits for specific spending categories so that I can manage spending in particular areas like food, transport, or entertainment.

**Why this priority**: Category-specific budgets give users more granular control over their finances and align with common budgeting methods.

**Independent Test**: Can be tested by setting a budget for a specific category, logging transactions in that category, and verifying progress updates correctly.

**Acceptance Scenarios**:

1. **Given** the user wants to set a category budget, **When** they select a category and set a limit, **Then** the budget is saved and tracks spending only for that category
2. **Given** category budgets are set, **When** viewing the budget overview, **Then** all category budgets are displayed with their individual progress

---

### User Story 3 - Saving Streak Tracking (Priority: P2)

As a user, I want to maintain a saving streak by staying within my budget so that I can build positive financial habits and see my progress visually.

**Why this priority**: Streaks add gamification and motivation, encouraging users to maintain good financial habits consistently.

**Independent Test**: Can be tested by maintaining spending within budget for multiple days and verifying the streak counter increases appropriately.

**Acceptance Scenarios**:

1. **Given** the user has no streak history, **When** they start using the app and stay within budget, **Then** a streak counter begins at 1 day
2. **Given** the user has a 5-day streak, **When** they log expenses that stay within budget, **Then** the streak increases to 6 days
3. **Given** the user has an active streak, **When** they exceed their budget, **Then** the streak resets to 0
4. **Given** the user views their dashboard, **When** they see the streak display, **Then** it shows the current streak count and a visual indicator

---

### User Story 4 - Budget Period Management (Priority: P3)

As a user, I want my budgets to reset at the start of each month so that I can track spending on a consistent monthly cycle.

**Why this priority**: Monthly reset aligns with typical budgeting cycles and ensures users can continuously track their finances without manual intervention.

**Independent Test**: Can be tested by setting a budget, progressing through the month, and verifying that at the new month the budget resets with fresh tracking.

**Acceptance Scenarios**:

1. **Given** the current month has spending tracked, **When** the calendar month changes, **Then** the spent amount resets to zero while the budget limit remains
2. **Given** a new month begins, **When** the user views their budget, **Then** they see a fresh progress indicator starting from 0%

---

### User Story 5 - Set Savings Goal (Priority: P2)

As a user, I want to set a savings goal with a target amount so that I can track my progress towards a specific financial target.

**Why this priority**: Saving goals give users something positive to work toward beyond just controlling spending - it adds a goal-oriented element to the app.

**Independent Test**: Can be tested by creating a savings goal, logging income/savings, and verifying progress towards the target.

**Acceptance Scenarios**:

1. **Given** the user has no savings goal, **When** they create a savings goal with a target amount, **Then** the goal is saved and displayed as active
2. **Given** a savings goal is active, **When** the user adds income or reduces expenses, **Then** the goal progress updates to show amount saved
3. **Given** the user has saved 50% of their goal, **When** they view the goal, **Then** they see a progress indicator showing 50% completion
4. **Given** the user reaches their savings goal, **When** they view the goal, **Then** they see a completion indicator

---

### Edge Cases

- ~~What happens when the user sets a budget of zero or negative amount?~~ (Resolved: Budget must be greater than zero)
- How does the system handle if no transactions have been logged for the month?
- ~~What happens when the streak is broken - is there any grace period or does it reset immediately?~~ (Resolved: No grace period, streak resets immediately)
- ~~How does the system handle budget setup if the user has no transaction history yet?~~ (Resolved: Users can set budgets freely)
- What happens when a category budget is set but the user deletes all transactions in that category?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST allow users to create a monthly budget with a specified spending limit greater than zero OR a savings goal with a target amount
- **FR-002**: System MUST display current spending against the budget as a percentage and visual progress
- **FR-003**: System MUST provide a warning when spending reaches 80% of the budget
- **FR-004**: System MUST provide an alert when spending exceeds the budget
- **FR-005**: Users MUST be able to set budget limits for individual spending categories
- **FR-006**: Users MUST be able to view all their budgets (total and category-specific) in one place
- **FR-007**: System MUST track and display a daily streak count showing consecutive days without overspending
- **FR-008**: System MUST increment the streak when the user stays within budget for a full day
- **FR-009**: System MUST reset the streak to zero when the user exceeds their budget
- **FR-010**: System MUST automatically reset budget spent amounts at the start of each new month
- **FR-011**: Users MUST be able to edit their budget limits after initial setup
- **FR-012**: Users MUST be able to delete a budget they no longer need
- **FR-013**: System MUST integrate with transaction data to calculate spending against budgets in real-time
- **FR-014**: System MUST display streak information prominently on the dashboard
- **FR-015**: Users MUST be able to create savings goals with a target amount
- **FR-016**: System MUST display savings goal progress as a percentage and visual indicator
- **FR-017**: System MUST track and display the current saved amount towards each savings goal
- **FR-018**: Users MUST be able to edit their savings goal target amount after initial setup
- **FR-019**: Users MUST be able to delete a savings goal they no longer need
- **FR-020**: System MUST provide a completion indicator when a savings goal target is reached

### Key Entities

- **Budget**: Represents a spending limit set by the user. Key attributes include: budget identifier, user reference, optional category association, limit amount, current spent amount, and period (monthly). Relationships: belongs to user, optionally linked to a transaction category.
- **SavingsGoal**: Represents a target amount the user wants to save. Key attributes include: goal identifier, user reference, target amount, current saved amount, name/description. Relationships: belongs to user, calculated from income transactions.
- **Streak**: Represents the user's consecutive days of staying within budget. Key attributes include: streak identifier, user reference, current streak count, last updated date. Relationships: belongs to user, calculated from daily budget compliance.
- **Transaction**: Already exists from Phase 4. Relationships: used by Budget to calculate spending, used by SavingsGoal to calculate saved amount.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can set up a budget in under 60 seconds from navigating to budget setup
- **SC-002**: Budget progress updates are visible immediately after adding a new transaction
- **SC-003**: 90% of users successfully complete budget setup on their first attempt
- **SC-004**: Users can see their current streak count within 2 seconds of opening the dashboard
- **SC-005**: Streak resets correctly and immediately when budget is exceeded
- **SC-006**: Budget warnings appear at the 80% threshold before the user exceeds their limit
- **SC-007**: Monthly budget reset happens automatically without user action required
- **SC-008**: Users can set up a savings goal in under 60 seconds
- **SC-009**: Savings goal progress updates are visible immediately after adding income
- **SC-010**: Goal completion is detected and displayed within 2 seconds of reaching target

## Assumptions

- Users have already completed Phase 4 (Transactions Module) and have transaction data available
- Budget periods align with calendar months (January through December)
- The app will track one streak per user (not per category)
- Budget overspending is determined by total spending against total budget, or category spending against category budget
- A day is considered "within budget" if all transactions logged for that day do not cause the user to exceed their budget
- Users may have multiple category budgets but only one total budget
- The streak tracks consecutive days where the user ends the day without having exceeded their budget at any point
- Budget limits must be greater than zero (positive amounts only)
- Streak resets immediately when budget is exceeded (no grace period)
- Users can set budgets at any time regardless of transaction history; app provides default category suggestions
- Savings goals track income transactions to calculate progress towards the target
- Users can have multiple savings goals simultaneously