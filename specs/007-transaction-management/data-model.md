# Data Model: Transactions Module

## Entities

### Transaction

| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | UUID | PRIMARY KEY, NOT NULL | Auto-generated unique identifier |
| user_id | UUID | NOT NULL, FK to auth.users | References the user who owns this transaction |
| amount | DECIMAL(15,2) | NOT NULL, > 0 | Transaction amount (supports cents) |
| type | VARCHAR(10) | NOT NULL, CHECK IN ('income', 'expense') | Transaction type |
| category | VARCHAR(50) | NOT NULL | Pre-defined category name |
| date | TIMESTAMP | NOT NULL, DEFAULT NOW() | Transaction date |
| note | TEXT | NULLABLE, MAX 500 chars | Optional user notes |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Record creation timestamp |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Record last update timestamp |

**Relationships**: 
- Belongs to User (via user_id)
- No foreign key to categories (pre-defined system values)

### Pre-defined Categories

Income:
- Salary
- Freelance
- Investment
- Gift
- Other Income

Expense:
- Food
- Transport
- Shopping
- Entertainment
- Bills
- Health
- Education
- Other Expense

---

## Validation Rules

From functional requirements:

1. **Amount** (FR-002)
   - Must be a positive number
   - Must be greater than zero
   - Supports two decimal places

2. **Type** (FR-003)
   - Required field
   - Must be either 'income' or 'expense'

3. **Category** (FR-003)
   - Required field
   - Must be one of the pre-defined categories

4. **Date**
   - Defaults to current timestamp
   - Allows backdating (user can select past dates)

5. **Note** (Assumption)
   - Optional field
   - Maximum 500 characters

---

## State Transitions

### Transaction Lifecycle

```
[Draft] → [Created] → [Updated] → [Deleted]
              ↓
         [Synced to Server]
```

- **Draft**: Local-only (when offline and queued)
- **Created**: Successfully saved to Supabase
- **Updated**: Modified (creates new updated_at timestamp)
- **Deleted**: Soft-deleted or hard-deleted (FR-006)
- **Synced to Server**: Confirmed in Supabase database

### Offline Queue State

When offline:
1. Transaction saved locally with [Draft] status
2. Queued for sync when connection restored
3. On reconnect: attempt sync, update status to [Synced to Server]
4. On sync failure: retain in queue, show error to user

---

## Row Level Security (RLS)

**Policy**: Users can only SELECT, INSERT, UPDATE, DELETE their own transactions.

```sql
-- Enable RLS
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

-- Policy: Owner can do everything with own records
CREATE POLICY "Users can manage own transactions" ON transactions
  FOR ALL
  USING (auth.uid() = user_id);
```

---

## Database Migration Plan

File: `migrations/001_create_transactions.sql`

1. Create `transactions` table with all fields
2. Add CHECK constraint for type values
3. Add indexes for common queries (user_id, date, category)
4. Enable RLS and create policies

Indexes:
- `idx_transactions_user_id` on user_id
- `idx_transactions_date` on date DESC
- `idx_transactions_type` on type
- `idx_transactions_category` on category

---

## Supabase CLI Commands

```bash
# Create migration
supabase migrations new create_transactions

# Apply migrations locally
supabase db reset

# Push to remote
supabase db push
```
