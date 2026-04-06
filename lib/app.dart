import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_companion_mobile_app/core/constants/app_constants.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:personal_finance_companion_mobile_app/features/auth/presentation/cubit/auth_state.dart'
    as auth;
import 'package:personal_finance_companion_mobile_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:personal_finance_companion_mobile_app/features/insights/presentation/cubit/insights_cubit.dart';
import 'package:personal_finance_companion_mobile_app/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:personal_finance_companion_mobile_app/features/settings/presentation/cubit/theme_cubit.dart';

import 'core/routes/app_router.dart';
import 'core/routes/route_constants.dart';
import 'core/services/dependency_injection.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';

class PersonalFinanceApp extends StatefulWidget {
  const PersonalFinanceApp({super.key});

  @override
  State<PersonalFinanceApp> createState() => _PersonalFinanceAppState();
}

class _PersonalFinanceAppState extends State<PersonalFinanceApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.router;
  }

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
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocListener<AuthCubit, auth.AuthState>(
        listener: (context, state) {
          if (state is auth.AuthAuthenticated) {
            _router.go(AppRoutes.dashboard);
          } else if (state is auth.AuthUnauthenticated) {
            _router.go(AppRoutes.login);
          }
        },
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return AnimatedTheme(
              data: Theme.of(context),
              duration: const Duration(milliseconds: 350),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: AppConstants.appName,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                routerConfig: _router,
              ),
            );
          },
        ),
      ),
    );
  }
}
