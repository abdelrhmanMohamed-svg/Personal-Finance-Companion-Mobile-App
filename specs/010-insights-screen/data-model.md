# Data Model: Phase 7 - Insights Screen

## Entities

### SpendingByCategory

Represents aggregated spending for each category within a time period.

| Field | Type | Description | Validation |
|-------|------|-------------|------------|
| category | String | Category name | Non-empty, from predefined list |
| total_amount | double | Total spent in category | >= 0 |
| percentage | double | Percentage of total spending | 0-100 |
| transaction_count | int | Number of transactions | >= 0 |

**Relationships**: Derived from Transaction entity

### WeeklyComparison

Represents comparison between current week and previous week spending.

| Field | Type | Description | Validation |
|-------|------|-------------|------------|
| current_week_total | double | Total spending this week | >= 0 |
| previous_week_total | double | Total spending last week | >= 0 |
| percentage_change | double | Change percentage | Can be negative |
| trend_direction | enum | up/down/same | Non-null |

### MonthlyTrend

Represents monthly spending for a single month.

| Field | Type | Description | Validation |
|-------|------|-------------|------------|
| month | String | Month identifier (YYYY-MM) | Non-empty |
| total_spending | double | Total spending for month | >= 0 |
| transaction_count | int | Number of transactions | >= 0 |

### TopCategory

Represents the highest spending category.

| Field | Type | Description | Validation |
|-------|------|-------------|------------|
| category | String | Category name | Non-empty |
| total_amount | double | Total spent | >= 0 |
| percentage | double | Percentage of total | 0-100 |

## Validation Rules

1. **Spending calculations**: Must exclude income transactions (FR-009)
2. **Refunds**: Subtract from category totals (per clarification)
3. **Top category tiebreaker**: Alphabetical order (per clarification)
4. **Time periods**: Current year for monthly trends (per clarification)

## State Transitions

### InsightsState

```
InsightsInitial
    ↓ (load requested)
InsightsLoading
    ↓ (data fetched)
InsightsLoaded
    ↓ (error occurs)
InsightsError
```

## Query Specifications

### Category Breakdown Query

```sql
SELECT 
  category,
  SUM(CASE WHEN amount < 0 THEN ABS(amount) ELSE amount END) as total_amount,
  COUNT(*) as transaction_count
FROM transactions
WHERE user_id = $1 
  AND type = 'expense'
  AND date >= $2
GROUP BY category
ORDER BY total_amount DESC
```

### Weekly Comparison Query

```sql
-- Current week (Monday-Sunday of current week)
SELECT SUM(amount) as total
FROM transactions
WHERE user_id = $1 
  AND type = 'expense'
  AND date >= date_trunc('week', CURRENT_DATE)
  AND date < date_trunc('week', CURRENT_DATE) + INTERVAL '1 week'

-- Previous week
SELECT SUM(amount) as total
FROM transactions
WHERE user_id = $1 
  AND type = 'expense'
  AND date >= date_trunc('week', CURRENT_DATE) - INTERVAL '1 week'
  AND date < date_trunc('week', CURRENT_DATE)
```

### Monthly Trends Query

```sql
SELECT 
  TO_CHAR(date, 'YYYY-MM') as month,
  SUM(ABS(amount)) as total_spending,
  COUNT(*) as transaction_count
FROM transactions
WHERE user_id = $1 
  AND type = 'expense'
  AND date >= date_trunc('year', CURRENT_DATE)
GROUP BY TO_CHAR(date, 'YYYY-MM')
ORDER BY month DESC
LIMIT 12
```
