import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
    final isAuthRoute = state.matchedLocation == '/login' ||
        state.matchedLocation == '/register' ||
        state.matchedLocation == '/forgot-password';

    if (!isLoggedIn && !isAuthRoute) {
      return '/login';
    }

    if (isLoggedIn && isAuthRoute) {
      return '/dashboard';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Home Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Login Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/register',
      name: RouteNames.register,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Register Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/forgot-password',
      name: RouteNames.forgotPassword,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Forgot Password Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/dashboard',
      name: RouteNames.dashboard,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Dashboard Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/transactions',
      name: RouteNames.transactions,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Transactions Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/goals',
      name: RouteNames.goals,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Goals Screen'),
        ),
      ),
    ),
    GoRoute(
      path: '/insights',
      name: RouteNames.insights,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Insights Screen'),
        ),
      ),
    ),
  ],
);
