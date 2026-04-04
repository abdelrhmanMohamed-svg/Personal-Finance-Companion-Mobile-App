import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../routes/route_names.dart';

class AuthGuard {
  static final _supabase = Supabase.instance.client;

  static GoRouter createRouter(
      {required Widget child, String? initialLocation}) {
    return GoRouter(
      initialLocation: initialLocation ?? '/',
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isLoggedIn = _supabase.auth.currentSession != null;
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
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/login',
          name: RouteNames.login,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/register',
          name: RouteNames.register,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/forgot-password',
          name: RouteNames.forgotPassword,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/dashboard',
          name: RouteNames.dashboard,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/transactions',
          name: RouteNames.transactions,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/goals',
          name: RouteNames.goals,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/insights',
          name: RouteNames.insights,
          builder: (context, state) => child,
        ),
      ],
    );
  }
}

class AuthRedirectMiddleware {
  static String? redirectIfUnauthenticated(String currentPath) {
    final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
    final isAuthRoute = currentPath == '/login' ||
        currentPath == '/register' ||
        currentPath == '/forgot-password';

    if (!isLoggedIn && !isAuthRoute) {
      return '/login';
    }

    if (isLoggedIn && isAuthRoute) {
      return '/dashboard';
    }

    return null;
  }
}
