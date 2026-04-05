# Feature Specification: Phase 7 - Insights Screen

**Feature Branch**: `010-insights-screen`  
**Created**: 2026-04-06  
**Status**: Draft  
**Input**: User description: "make a spec for ### Phase 7: Insights Screen you will find in C:\rich_Sonic\personal_finance_companion_mobile_app\plan.md"

## Clarifications

### Session 2026-04-06

- Q: How should multi-year transaction history be handled in monthly trends? → A: Current year only - Shows monthly trends for the current calendar year
- Q: How should refunds and negative amounts affect spending calculations? → A: Subtract from category totals - Net spending = expenses minus refunds
- Q: When categories have equal spending amounts, how should "top spending category" be determined? → A: First alphabetically - Use alphabetical order as tiebreaker
- Q: When users delete transactions, should insights update in real-time or require manual refresh? → A: Real-time updates - Insights recalculate immediately when transactions change

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Spending by Category (Priority: P1)

As a user, I want to see a breakdown of my spending by category so I can understand where most of my money goes.

**Why this priority**: This is the primary insight users need to identify spending patterns and make informed budget decisions.

**Independent Test**: User opens the Insights screen and immediately sees a visual breakdown of spending by category with percentages and amounts.

**Acceptance Scenarios**:

1. **Given** the user has at least one expense transaction, **When** they open the Insights screen, **Then** they see a clear category breakdown showing amount and percentage for each spending category.
2. **Given** the user has no expense transactions, **When** they open the Insights screen, **Then** they see a friendly empty state explaining that adding transactions will generate insights.
3. **Given** the user has transactions in multiple categories, **When** they view the category breakdown, **Then** categories are displayed in descending order by amount (highest spenders at top).

---

### User Story 2 - Compare Weekly Spending (Priority: P2)

As a user, I want to compare this week's spending with last week's spending so I can track whether my spending is increasing or decreasing.

**Why this priority**: Weekly comparison provides actionable feedback on spending trends and helps users stay accountable to their financial goals.

**Independent Test**: User navigates to the weekly comparison section and sees side-by-side comparison of current week vs previous week with percentage change indicator.

**Acceptance Scenarios**:

1. **Given** the user has transactions in both the current week and previous week, **When** they view weekly comparison, **Then** they see the total spent this week, total spent last week, and the percentage change.
2. **Given** the user spent less this week than last week, **When** they view weekly comparison, **Then** the comparison shows a positive indicator (green arrow or color) with the percentage decrease.
3. **Given** the user spent more this week than last week, **When** they view weekly comparison, **Then** the comparison shows a warning indicator (red arrow or color) with the percentage increase.
4. **Given** the user has no transactions in either week, **When** they view weekly comparison, **Then** they see a message indicating insufficient data for comparison.

---

### User Story 3 - View Monthly Trends (Priority: P2)

As a user, I want to see my spending trends over the past several months so I can identify seasonal patterns and long-term spending behavior.

**Why this priority**: Monthly trends help users understand their financial behavior over time and plan for recurring expenses.

**Independent Test**: User scrolls to the monthly trends section and sees a chart or list showing spending for each of the past 3-6 months.

**Acceptance Scenarios**:

1. **Given** the user has at least one month of transaction history, **When** they view monthly trends, **Then** they see a visual representation (chart or list) showing total spending for each of the past months.
2. **Given** the user has 3+ months of history, **When** they view monthly trends, **Then** they can see clear month-over-month changes.
3. **Given** the user has less than 2 months of history, **When** they view monthly trends, **Then** they see a message indicating that more data is needed to show trends.

---

### User Story 4 - Identify Top Spending Category (Priority: P2)

As a user, I want to quickly see which category I spend the most on so I can focus on reducing that spending if needed.

**Why this priority**: Top spending category provides immediate focus areas for budget improvement.

**Independent Test**: User sees their top spending category highlighted at the top of the category breakdown with a visual indicator.

**Acceptance Scenarios**:

1. **Given** the user has expense transactions across multiple categories, **When** they view the category breakdown, **Then** the highest spending category is visually highlighted (larger size, different color, or badge).
2. **Given** the user has only one category of spending, **When** they view insights, **Then** that category is still identified as the top category but with appropriate messaging.

---

### Edge Cases

- ~~What happens when a user has transactions spanning multiple years - should trends show current year only or all-time data?~~ Resolved: Monthly trends show current year only.
- ~~How does the system handle negative amounts or refunds in the spending calculations?~~ Resolved: Refunds subtract from category totals.
- ~~What happens when categories have equal spending amounts - how is "top" determined?~~ Resolved: First alphabetically as tiebreaker.
- ~~How does the system handle users who delete transactions - does it update insights in real-time?~~ Resolved: Real-time updates.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display a spending breakdown by category showing total amount and percentage for each category.
- **FR-002**: System MUST calculate and display weekly spending comparison showing current week vs previous week with percentage change.
- **FR-003**: System MUST display monthly spending trends for at least the past 3 months.
- **FR-004**: System MUST highlight the user's top spending category with a visual indicator.
- **FR-005**: System MUST calculate all insights from existing transaction data without requiring additional user input.
- **FR-006**: System MUST update insights automatically when new transactions are added, edited, or deleted.
- **FR-007**: System MUST handle empty states gracefully with helpful messages instead of showing errors.
- **FR-008**: System MUST display positive/negative trends using intuitive visual indicators (colors, arrows, or icons).
- **FR-009**: System MUST exclude income transactions from spending calculations.

### Key Entities *(include if feature involves data)*

- **Transaction**: Used as the data source for all insights calculations. Relevant attributes include amount, type (income/expense), category, and date.
- **Spending Summary**: Calculated entity that aggregates total spending by category, time period, or other dimensions.
- **Trend Comparison**: Calculated entity comparing current period spending against previous period spending.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can view their category spending breakdown within 2 seconds of opening the Insights screen.
- **SC-002**: Weekly comparison accurately reflects percentage change between current and previous week spending.
- **SC-003**: Monthly trends display at least 3 months of historical data for users with sufficient transaction history.
- **SC-004**: Top spending category is correctly identified and highlighted in at least 95% of cases where the user has multiple categories.
- **SC-005**: Empty states are displayed within 1 second when no transaction data is available for a given insight type.
- **SC-006**: 90% of users successfully identify their top spending category on first use of the Insights screen.

## Assumptions

- **Data Source**: Insights will be calculated from the existing transaction data model already implemented in the Transactions feature.
- **Time Period Definitions**: Current week is defined as the calendar week containing today's date; previous week is the calendar week immediately before.
- **Category List**: Categories are pre-defined from the existing transaction feature (e.g., Food, Transport, Entertainment, Shopping, Bills, Health, Other).
- **Exclusions**: Refunds and adjustments will be handled by subtracting their amounts from the relevant category totals.
- **Real-time Updates**: Insights will recalculate automatically when the user navigates to the screen (no manual refresh required).
- **Performance**: Insights calculations will be optimized to complete within acceptable mobile app response times.
