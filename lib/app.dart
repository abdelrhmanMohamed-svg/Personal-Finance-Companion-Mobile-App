import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/cubits/auth_state.dart'
    as auth;
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/screens/register_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/goals/presentation/screens/goals_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/transactions/domain/entities/transaction.dart';
import 'package:personal_finance_companion_mobile_app/features/transactions/presentation/screens/add_edit_transaction_screen.dart';
import 'package:personal_finance_companion_mobile_app/features/transactions/presentation/screens/transactions_list_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/dependency_injection.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'features/insights/presentation/cubit/insights_cubit.dart';
import 'features/insights/presentation/screens/insights_screen.dart';
import 'features/transactions/presentation/cubits/transactions_cubit.dart';

class PersonalFinanceApp extends StatelessWidget {
  const PersonalFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(getIt<SupabaseService>())..checkAuthStatus(),
        ),
        BlocProvider<TransactionsCubit>(
          create: (_) => TransactionsCubit(getIt(), getIt()),
        ),
        BlocProvider<DashboardCubit>(create: (_) => getIt<DashboardCubit>()),
        BlocProvider<InsightsCubit>(create: (_) => getIt<InsightsCubit>()),
      ],
      child: BlocListener<AuthCubit, auth.AuthState>(
        listener: (context, state) {
          if (state is auth.AuthAuthenticated) {
            GoRouter.of(context).go('/dashboard');
          } else if (state is auth.AuthUnauthenticated) {
            GoRouter.of(context).go('/login');
          }
        },
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
      ),
    );
  }
}

String _getInitialLocation() {
  final session = Supabase.instance.client.auth.currentSession;
  return session != null ? '/dashboard' : '/login';
}

final _router = GoRouter(
  initialLocation: _getInitialLocation(),
  debugLogDiagnostics: false,
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/transactions',
      builder: (context, state) => const TransactionsListScreen(),
    ),
    GoRoute(
      path: '/transactions/add',
      builder: (context, state) {
        final transaction = state.extra as Transaction?;
        return AddEditTransactionScreen(transaction: transaction);
      },
    ),
    GoRoute(path: '/goals', builder: (context, state) => const GoalsScreen()),
    GoRoute(
      path: '/insights',
      builder: (context, state) => const InsightsScreen(),
    ),
  ],
);
