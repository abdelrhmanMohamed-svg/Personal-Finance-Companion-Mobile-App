# Quickstart: Transactions Module Implementation

## Prerequisites

1. **Supabase Project**: Ensure a Supabase project exists with:
   - Authentication enabled
   - Database ready

2. **Supabase CLI Installed**: 
   ```bash
   # Verify installation
   supabase --version
   ```

3. **Flutter Environment**: 
   - Flutter 3.x installed
   - Dependencies installed: `flutter pub get`

---

## Step 1: Database Setup

### 1.1 Create Migration

Create file: `supabase/migrations/001_create_transactions.sql`

```sql
-- Transactions table for Phase 4
CREATE TABLE IF NOT EXISTS public.transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id),
    amount DECIMAL(15,2) NOT NULL CHECK (amount > 0),
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    category VARCHAR(50) NOT NULL,
    date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    note TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;

-- RLS Policy
CREATE POLICY "Users can manage own transactions" ON public.transactions
    FOR ALL
    USING (auth.uid() = user_id);

-- Indexes
CREATE INDEX idx_transactions_user_id ON public.transactions(user_id);
CREATE INDEX idx_transactions_date ON public.transactions(date DESC);
CREATE INDEX idx_transactions_type ON public.transactions(type);
CREATE INDEX idx_transactions_category ON public.transactions(category);
```

### 1.2 Apply Migration

```bash
# From project root
cd supabase
supabase db push
```

---

## Step 2: Flutter Implementation

### 2.1 Create Transaction Feature Structure

```
lib/features/transactions/
├── data/
│   ├── models/transaction_model.dart
│   ├── repositories/transaction_repository_impl.dart
│   └── datasources/transaction_datasource.dart
├── domain/
│   ├── entities/transaction.dart
│   ├── repositories/transaction_repository.dart
│   └── usecases/
│       ├── add_transaction.dart
│       ├── get_transactions.dart
│       ├── update_transaction.dart
│       └── delete_transaction.dart
└── presentation/
    ├── cubits/transactions_cubit.dart
    ├── cubits/transactions_state.dart
    ├── screens/
    │   ├── transactions_screen.dart
    │   └── add_edit_transaction_screen.dart
    └── widgets/
        ├── transaction_list_item.dart
        ├── transaction_filter_sheet.dart
        └── empty_state_widget.dart
```

### 2.2 Key Implementation Notes

- Use `TransactionsCubit` for all transaction state management
- Repository pattern for data access abstraction
- Offline queue: Save to local storage first, then sync to Supabase
- Use `screen_util_flutter` for responsive layouts (per existing patterns)

### 2.3 Dependencies

The following are already in pubspec.yaml (verify):
- flutter_bloc
- supabase_flutter
- equatable
- screen_util_flutter

---

## Step 3: Testing

### 3.1 Unit Tests
- Test repository methods
- Test use cases
- Test Cubit state transitions

### 3.2 Widget Tests
- Test transaction list renders correctly
- Test add/edit form validation
- Test filter/search functionality

### 3.3 Integration Tests
- Full transaction CRUD flow
- Offline queue and sync flow

---

## Verification

After implementation, verify:

1. ✅ Can add a new transaction
2. ✅ Can view transaction list (sorted by date, newest first)
3. ✅ Can edit existing transaction
4. ✅ Can delete transaction with confirmation
5. ✅ Can filter by type (income/expense)
6. ✅ Can filter by date range
7. ✅ Can search by note or category
8. ✅ Empty state displays when no transactions
9. ✅ Offline transactions are queued and synced

---

## Common Issues

| Issue | Solution |
|-------|----------|
| RLS blocking inserts | Ensure user is authenticated before operations |
| Offline data lost | Implement local queue storage (Hive/SQFlite) |
| Slow list loading | Add pagination or lazy loading |
| Validation errors | Check amount > 0 and type/category required |
