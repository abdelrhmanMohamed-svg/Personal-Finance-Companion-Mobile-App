import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
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
