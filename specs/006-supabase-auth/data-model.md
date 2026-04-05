# Data Model: Supabase Authentication

**Feature**: Phase 3 - Authentication (Supabase)

## Entities

### User (Supabase Auth - managed)

| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Unique user identifier |
| email | TEXT | User email address |
| created_at | TIMESTAMP | Account creation time |
| last_sign_in_at | TIMESTAMP | Last login time |
| email_confirmed_at | TIMESTAMP | Email verification time |

> Note: User table is managed by Supabase Auth - no migration needed for core authentication.

### Session (Runtime - managed by supabase_flutter)

| Field | Type | Description |
|-------|------|-------------|
| access_token | TEXT | JWT token for API requests |
| refresh_token | TEXT | Token to refresh session |
| expires_at | INTEGER | Unix timestamp of expiration |
| user_id | UUID | Associated user ID |

> Note: Session is managed automatically by supabase_flutter SDK.

### UserProfile (Future Phase)

| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Primary key |
| user_id | UUID | Foreign key to auth.users |
| created_at | TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | Last update time |

> Note: UserProfile table is NOT created in this phase - deferred to future phases when additional user data is needed.

## Validation Rules

### Email Validation
- Must be valid email format (regex: `/^[^\s@]+@[^\s@]+\.[^\s@]+$/`)
- Max length: 255 characters
- Must be unique in auth.users table

### Password Validation
- Minimum 8 characters
- No maximum limit enforced by Supabase

## State Transitions

### Auth State Machine

```
┌─────────────────┐
│   Initializing  │ ← App launch
└────────┬────────┘
         │
         ▼
    ┌──────────┐    ┌─────────┐
    │Unauthenticated│ ◄─────┤ Authenticated
    └────┬─────┘         │ (valid session)
         │               │
    ┌────▼────┐          │
    │ Login   │          │ Session
    │ Screen  │          │ Expired
    └────┬────┘          ▼
         │          ┌──────────┐
         ▼          │ Unauthenticated│
    ┌─────────┐     └──────────┘
    │ Authenticated│
    └─────────────┘
```

## Relationships

- **User → Session**: One-to-one (one active session per user)
- **User → UserProfile**: One-to-one (optional, deferred)

## Security Considerations

- Passwords are hashed by Supabase (bcrypt)
- Tokens stored securely via platform keychain
- Session tokens expire (configurable in Supabase dashboard)
- RLS policies deferred to future phase
