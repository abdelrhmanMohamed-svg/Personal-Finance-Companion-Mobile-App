# Insights Screen Design

**Task**: T029 - Design Insights screen

## Screen Overview

The Insights screen shows financial analytics, trends, and spending insights.

## Layout Structure

### Header Section
- **Title**: "Insights"
- **Period Selector**: Dropdown (This Week, This Month, This Year, Custom)

### Overview Cards Section
- **Layout**: 2-column grid
- **Total Spent**: Amount + change vs previous period
- **Average Daily**: Spending average
- **Top Category**: Highest spending category
- **Transactions**: Total count

### Spending by Category
- **Chart Type**: Donut chart or horizontal bar chart
- **Categories**: List with amounts and percentages
- **Legend**: Color-coded category list
- **Tap**: Filter transactions by category

### Trends Section
- **Chart Type**: Line chart
- **Data**: Daily/weekly spending over time
- **X-Axis**: Date
- **Y-Axis**: Amount
- **Comparison**: Show vs previous period overlay

### Income vs Expenses
- **Chart Type**: Bar chart (side by side)
- **Periods**: Last 6 months
- **Values**: Income and expenses per month

### Insights & Tips
- **Type**: Cards with insights
- **Examples**:
  - "You spent 20% more on dining this month"
  - "You've met your savings goal for this month!"
  - "Your top expense category is Shopping"
- **Style**: Info card with icon

## Charts Design

### Donut Chart
- **Size**: 200x200px
- **Stroke Width**: 32px
- **Center**: Total amount or percentage
- **Animation**: Animate on load

### Bar Chart
- **Bar Width**: 24px
- **Bar Gap**: 16px
- **Rounded Corners**: 4px top
- **Labels**: Below bars
- **Values**: Above bars

### Line Chart
- **Line Width**: 2px
- **Data Points**: 6px circles
- **Fill**: Gradient below line
- **Grid Lines**: Subtle, dashed

## Interactions

### Tap Period Selector
- Open dropdown with options
- Select to update all data

### Tap Chart Segment
- Show detail tooltip
- Option to filter transactions

### Pull to Refresh
- Refresh all insights data

### Scroll
- Smooth scroll through sections

## States

### Loading
- Show skeleton cards
- Show shimmer for charts

### No Data
- Show "Not enough data" message
- Show minimum data requirements

### Error
- Show error card
- Retry button

### With Data
- Show all charts and insights

## Visual Design

### Colors
- Background: `#FAFAFA` (light) / `#121212` (dark)
- Chart Colors: Category colors
- Income: `#43A047`
- Expense: `#E53935`
- Positive change: Green
- Negative change: Red

### Typography
- Screen title: `headline-lg`
- Section header: `headline-sm`
- Card value: `amount-lg`
- Card label: `body-sm`
- Chart labels: `label-sm`

### Spacing
- Screen padding: 16px
- Card padding: 16px
- Chart spacing: 24px
- Section spacing: 32px
