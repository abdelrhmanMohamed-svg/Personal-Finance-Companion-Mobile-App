import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/screens/register_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/goals/presentation/screens/goals_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/insights/presentation/screens/insights_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/transactions/presentation/screens/add_edit_transaction_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/transactions/presentation/screens/transactions_list_screen.dart';

import 'core/services/dependency_injection.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class PersonalFinanceApp extends StatefulWidget {
  const PersonalFinanceApp({super.key});

  @override
  State<PersonalFinanceApp> createState() => _PersonalFinanceAppState();
}

class _PersonalFinanceAppState extends State<PersonalFinanceApp> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit(getIt<SupabaseService>());
    
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn || 
          event.event == AuthChangeEvent.initialSession) {
        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          _authCubit.updateAuthState(user.id);
          _routerRefresh.refresh();
        }
      } else if (event.event == AuthChangeEvent.signedOut) {
        _authCubit.emitUnauthenticated();
        _routerRefresh.refresh();
      }
    });
    
    // Check auth status after listener is set up
    _authCubit.checkAuthStatus();
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: _authCubit),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Personal Finance Companion',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

class _GoRouterRefreshNotifier extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}

final _routerRefresh = _GoRouterRefreshNotifier();

final _router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  refreshListenable: _routerRefresh,
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;
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
    GoRoute(path: '/', redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) return '/dashboard';
      return '/login';
    }),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),
    GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
    GoRoute(path: '/transactions', builder: (context, state) => const TransactionsListScreen()),
    GoRoute(path: '/add-transaction', builder: (context, state) => const AddEditTransactionScreen()),
    GoRoute(path: '/goals', builder: (context, state) => const GoalsScreen()),
    GoRoute(path: '/insights', builder: (context, state) => const InsightsScreen()),
  ],
);
