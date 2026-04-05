# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement Supabase-based authentication for the Personal Finance Companion mobile app. This phase provides user signup, login, password reset, session management, and logout functionality using Supabase's built-in authentication service with optional user profile table via migrations.

## Technical Context

**Language/Version**: Dart 3.x with Flutter 3.x  
**Primary Dependencies**: flutter_bloc (Cubit), supabase_flutter, go_router, get_it, equatable, screen_util_flutter, google_fonts  
**Storage**: Supabase (Auth + PostgreSQL)  
**Testing**: Flutter test framework  
**Target Platform**: Mobile (iOS/Android)  
**Project Type**: Mobile app  
**Performance Goals**: Auto-login within 3 seconds, session refresh handled gracefully  
**Constraints**: Must work online, session tokens stored securely on device  
**Scale/Scope**: Single-user mobile app, Phase 3 of 10 phases

## Constitution Check (Post-Design)

*GATE: Re-evaluated after Phase 1 design*

| Constitution Principle | Alignment | Notes |
|------------------------|-----------|-------|
| I. Feature-First Architecture | ✅ PASS | Auth feature has data/domain/presentation layers |
| II. Cubit State Management | ✅ PASS | AuthCubit defined for auth state |
| III. Supabase Integration | ✅ PASS | Using supabase_flutter for Auth |
| IV. Test-Driven Quality | ✅ PASS | Quickstart includes test commands |
| V. Phase-Gated Development | ✅ PASS | Phase 3 implementation as planned |

**Gate Status**: ✅ PASSED - All constitution gates maintained after design

## Project Structure

### Documentation (this feature)

```text
specs/006-supabase-auth/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
├── core/
│   ├── theme/
│   ├── utils/
│   └── services/
├── features/
│   └── auth/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
└── main.dart

supabase/
└── migrations/
    └── 001_auth_setup.sql

tests/
├── unit/
│   └── auth/
└── widget/
    └── auth/
```

**Structure Decision**: Using feature-based architecture with data/domain/presentation layers per Constitution. Supabase migrations stored in supabase/migrations/ directory.

## Phase 0: Outline & Research

### Research Tasks

| Task | Description | Status |
|------|-------------|--------|
| Supabase Auth Flutter Integration | Research supabase_flutter package usage patterns | COMPLETED |
| Supabase CLI Migrations | Research migration file creation and management | COMPLETED |
| Session Persistence | Research secure token storage on mobile | COMPLETED |

### Research Findings

- **Decision**: Use supabase_flutter package for authentication
- **Rationale**: Official Flutter SDK from Supabase, provides session management, secure storage, and simple API
- **Alternatives considered**: Custom HTTP client, goTrue library (rejected - less maintained)

---

## Phase 1: Design & Contracts

### Data Model

**Auth Entities**:
- **User**: id (uuid), email, created_at (managed by Supabase Auth)
- **Session**: access_token, refresh_token, expires_at, user_id (managed by supabase_flutter)
- **UserProfile**: id, user_id, created_at, updated_at (future phase - not needed for auth)

### Supabase Migration Structure

```sql
-- Migration: 001_auth_setup.sql
-- Purpose: Setup auth configuration for Personal Finance Companion

-- Enable email auth (built-in, no migration needed)
-- Configure session settings in Supabase dashboard

-- Optional: Create user_profiles table for future phases
-- CREATE TABLE user_profiles (
--   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
--   created_at TIMESTAMPTZ DEFAULT NOW(),
--   updated_at TIMESTAMPTZ DEFAULT NOW()
-- );
```

### Quickstart

1. Install dependencies: `flutter pub add supabase_flutter`
2. Configure Supabase client in lib/core/services/
3. Create AuthCubit for state management
4. Implement Login/Signup/Logout pages
5. Setup session persistence with go_router guard
6. Run migration: `supabase db push`

### Contracts

Authentication feature exposes:
- AuthCubit (state management via flutter_bloc)
- AuthRepository (domain layer interface)
- AuthService (data layer implementation)
- LoginPage, SignupPage, ForgotPasswordPage (UI)

No external API contracts - this is a mobile app with internal Supabase integration.
