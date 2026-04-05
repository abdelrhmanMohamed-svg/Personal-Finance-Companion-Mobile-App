# Tasks: Transactions Module (Core Feature)

**Feature**: Transactions Module (Phase 4)  
**Branch**: `007-transaction-management`  
**Generated**: 2026-04-05  
**Spec**: [spec.md](spec.md) | [plan.md](plan.md) | [data-model.md](data-model.md)

---

## Dependency Graph

```
┌─────────────────────────────────────────────────────────────┐
│ Phase 1: Setup                                              │
│ (T001-T003)                                                 │
└──────────────────────────┬──────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────┐
│ Phase 2: Foundational                                        │
│ (T004-T008)                                                  │
│ - Transaction Entity, Model, Repository Interface            │
│ - TransactionsCubit base state                                │
└──────────────────────────┬──────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
┌───────────────┐  ┌───────────────┐  ┌───────────────┐
│ US1: Add      │  │ US2: View    │  │ US3: Edit     │
│ (T009-T012)   │  │ (T013-T016)  │  │ (T017-T020)   │
└───────┬───────┘  └───────┬───────┘  └───────┬───────┘
        │                  │                  │
        └──────────────────┼──────────────────┘
                           │
        ┌──────────────────▼──────────────────┐
        │ US4: Delete (T021-T023)            │
        │ US5: Filter/Search (T024-T026)    │
        └────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────┐
│ Phase 7: Polish (T027-T028)                                 │
└─────────────────────────────────────────────────────────────┘
```

---

## Implementation Strategy

**MVP Scope**: User Story 1 (Add Transaction) + User Story 2 (View History)
- T009-T016 deliver core transaction CRUD
- Can ship after Phase 3 (User Stories 1-2)

**Incremental Delivery**:
1. First: US1 + US2 (MVP)
2. Second: US3 + US4 (Edit/Delete)
3. Third: US5 (Filter/Search)
4. Fourth: Polish

---

## Phase 1: Setup

- [X] T001 Create feature directory structure in lib/features/transactions/
- [X] T002 [P] Create data layer directories (models/, repositories/, datasources/)
- [X] T003 [P] Create domain layer directories (entities/, repositories/, usecases/)

---

## Phase 2: Foundational

**Goal**: Establish the core data layer that ALL user stories depend on

**Independent Test**: Can add a transaction using the repository without UI

- [X] T004 [P] Create Transaction entity in lib/features/transactions/domain/entities/transaction.dart
- [X] T005 [P] Create TransactionModel in lib/features/transactions/data/models/transaction_model.dart
- [X] T006 Create TransactionRepository interface in lib/features/transactions/domain/repositories/transaction_repository.dart
- [X] T007 Create TransactionsCubit in lib/features/transactions/presentation/cubits/transactions_cubit.dart
- [X] T008 Create TransactionsState in lib/features/transactions/presentation/cubits/transactions_state.dart

---

## Phase 3: User Story 1 - Add Transaction (Priority: P1)

**Goal**: Users can create new income/expense transactions

**Independent Test**: Can create a transaction with all required fields and verify it appears in list

**Acceptance Scenarios**:
1. User enters amount, selects type, chooses category, taps save → Transaction saved and visible
2. User enters 0 or empty amount → Validation error displayed
3. User selects category → Category persists for future transactions

### Implementation

- [X] T009 [US1] Implement add_transaction usecase in lib/features/transactions/domain/usecases/add_transaction.dart
- [X] T010 [US1] Implement TransactionRepositoryImpl in lib/features/transactions/data/repositories/transaction_repository_impl.dart
- [X] T011 [US1] Create AddEditTransactionScreen in lib/features/transactions/presentation/screens/add_edit_transaction_screen.dart
- [X] T012 [US1] Implement TransactionsCubit.addTransaction() method with validation

---

## Phase 4: User Story 2 - View Transaction History (Priority: P1)

**Goal**: Users can see all their transactions in a scrollable list

**Independent Test**: Can view transaction list and confirm added transactions appear

**Acceptance Scenarios**:
1. User opens transactions screen → Transactions displayed newest first
2. User has no transactions → Empty state message displayed
3. User scrolls down → Older transactions load progressively

### Implementation

- [X] T013 [US2] Implement get_transactions usecase in lib/features/transactions/domain/usecases/get_transactions.dart
- [X] T014 [US2] Create TransactionsScreen in lib/features/transactions/presentation/screens/transactions_screen.dart
- [X] T015 [US2] Create TransactionListItem widget in lib/features/transactions/presentation/widgets/transaction_list_item.dart
- [X] T016 [US2] Create EmptyStateWidget in lib/features/transactions/presentation/widgets/empty_state_widget.dart

---

## Phase 5: User Story 3 - Edit Transaction (Priority: P2)

**Goal**: Users can modify existing transactions to correct mistakes

**Independent Test**: Can select transaction, change details, and verify changes persist

**Acceptance Scenarios**:
1. User taps transaction and modifies amount → Updated amount reflected in list
2. User changes type from expense to income → Transaction repositioned appropriately

### Implementation

- [X] T017 [US3] Implement update_transaction usecase in lib/features/transactions/domain/usecases/update_transaction.dart
- [X] T018 [US3] Add edit functionality to AddEditTransactionScreen (reuse from T011)
- [X] T019 [US3] Implement TransactionsCubit.updateTransaction() method
- [X] T020 [US3] Handle list repositioning when transaction type changes

---

## Phase 6: User Story 4 - Delete Transaction (Priority: P2)

**Goal**: Users can remove unwanted or duplicate transactions

**Independent Test**: Can delete transaction and confirm it's removed from list

**Acceptance Scenarios**:
1. User selects delete → Transaction removed from list, totals updated
2. User initiates delete → Confirmation prompt appears

### Implementation

- [X] T021 [US4] Implement delete_transaction usecase in lib/features/transactions/domain/usecases/delete_transaction.dart
- [X] T022 [US4] Add delete option to TransactionListItem (context menu or swipe)
- [X] T023 [US4] Implement confirmation dialog and TransactionsCubit.deleteTransaction() method

---

## Phase 7: User Story 5 - Filter and Search (Priority: P3)

**Goal**: Users can find specific transactions quickly

**Independent Test**: Can apply filters and search, verify only matching transactions display

**Acceptance Scenarios**:
1. User filters by "expense" → Only expense transactions displayed
2. User filters by specific month → Only transactions from that month displayed
3. User searches for keyword → Transactions matching note/category filtered in real-time

### Implementation

- [X] T024 [US5] Implement filter_transactions usecase in lib/features/transactions/domain/usecases/filter_transactions.dart
- [X] T025 [US5] Create TransactionFilterSheet widget in lib/features/transactions/presentation/widgets/transaction_filter_sheet.dart
- [X] T026 [US5] Add search bar to TransactionsScreen and implement real-time filtering

---

## Phase 8: Polish & Cross-Cutting

**Goal**: Handle edge cases and improve UX

- [X] T027 ~~Add offline queue handling (local storage + sync on reconnect)~~ - Skipped (Supabase handles offline scenarios)
- [X] T028 Add loading states and error handling throughout the feature

---

## Summary

| Phase | User Story | Tasks | Priority |
|-------|------------|-------|----------|
| 1 | Setup | 3 | - |
| 2 | Foundational | 5 | - |
| 3 | US1: Add Transaction | 4 | P1 |
| 4 | US2: View History | 4 | P1 |
| 5 | US3: Edit Transaction | 4 | P2 |
| 6 | US4: Delete Transaction | 3 | P2 |
| 7 | US5: Filter/Search | 3 | P3 |
| 8 | Polish | 2 | - |

**Total Tasks**: 28  
**MVP Tasks** (US1 + US2): 13  
**Parallelizable Tasks**: 5 (marked with [P])

**Suggested MVP Scope**: Tasks T001-T016 (Phases 1-4)
- Delivers core transaction add/view functionality
- Can be shipped after implementation
