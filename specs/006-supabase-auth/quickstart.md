# Quickstart: Supabase Authentication

**Feature**: Phase 3 - Authentication (Supabase)

## Prerequisites

1. Flutter 3.x with Dart 3.x
2. Supabase project created at https://supabase.com
3. Supabase CLI installed: `npm install -g supabase`

## Setup Steps

### Step 1: Install Dependencies

```bash
flutter pub add supabase_flutter flutter_bloc go_router get_it equatable
```

### Step 2: Configure Supabase Client

Create `lib/core/services/supabase_service.dart`:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient _client = SupabaseClient(
    'YOUR_SUPABASE_URL',
    'YOUR_SUPABASE_ANON_KEY',
  );
  
  static SupabaseClient get client => _client;
}
```

### Step 3: Initialize Supabase in main.dart

```dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  
  runApp(const MyApp());
}
```

### Step 4: Create Auth Feature Structure

```text
lib/features/auth/
├── data/
│   ├── models/
│   │   └── user_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user.dart
│   └── repositories/
│       └── auth_repository.dart
└── presentation/
    ├── cubit/
    │   ├── auth_cubit.dart
    │   ├── auth_state.dart
    │   └── auth_event.dart
    ├── pages/
    │   ├── login_page.dart
    │   ├── signup_page.dart
    │   └── forgot_password_page.dart
    └── widgets/
        └── auth_form.dart
```

### Step 5: Create Auth Cubit

```dart
// lib/features/auth/presentation/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
}

class AuthCubit extends Cubit<AuthState> {
  final SupabaseClient _supabase;
  
  AuthCubit(this._supabase) : super(AuthState(status: AuthStatus.initial));
  
  // Check current session on app start
  Future<void> checkSession() async {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      emit(AuthState(status: AuthStatus.authenticated, user: session.user));
    } else {
      emit(AuthState(status: AuthStatus.unauthenticated));
    }
  }
  
  // Sign up with email/password
  Future<void> signUp(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        emit(AuthState(status: AuthStatus.authenticated, user: response.user));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, errorMessage: e.toString()));
    }
  }
  
  // Sign in with email/password
  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        emit(AuthState(status: AuthStatus.authenticated, user: response.user));
      }
    } catch (e) {
      emit(AuthState(status: AuthStatus.unauthenticated, errorMessage: e.toString()));
    }
  }
  
  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    emit(AuthState(status: AuthStatus.unauthenticated));
  }
  
  // Reset password
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
}
```

### Step 6: Setup Route Guard

```dart
// In your router configuration
GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final authCubit = context.read<AuthCubit>();
    final isLoggedIn = authCubit.state.status == AuthStatus.authenticated;
    final isAuthRoute = state.matchedLocation == '/login' || 
                        state.matchedLocation == '/signup';
    
    if (!isLoggedIn && !isAuthRoute) {
      return '/login';
    }
    if (isLoggedIn && isAuthRoute) {
      return '/dashboard';
    }
    return null;
  },
  routes: [
    // ... auth routes
    // ... protected routes
  ],
)
```

### Step 7: Database Migration

Create migration file `supabase/migrations/001_auth_setup.sql`:

```sql
-- Migration: 001_auth_setup.sql
-- Phase 3: Authentication
-- This migration is informational - Supabase Auth is enabled by default

-- Verify auth is enabled (run in Supabase dashboard)
-- SELECT * FROM pg_extension WHERE extname = 'auth';

-- Optional: Create user_profiles table for future phases
-- CREATE TABLE IF NOT EXISTS user_profiles (
--   id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--   user_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
--   created_at TIMESTAMPTZ DEFAULT NOW(),
--   updated_at TIMESTAMPTZ DEFAULT NOW()
-- );
```

Apply migration:
```bash
supabase db push
```

## Testing

```bash
# Run tests
flutter test

# Run specific auth tests
flutter test test/auth/
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Session not persisting | Check secure storage is enabled in Supabase |
| Auth redirect not working | Verify URL scheme in mobile config |
| Password reset email not received | Check spam folder, verify email in Supabase console |
