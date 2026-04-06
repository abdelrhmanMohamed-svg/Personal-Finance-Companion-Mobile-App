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

import 'core/routes/app_router.dart';
import 'core/routes/route_constants.dart';
import 'core/services/dependency_injection.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';

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
            context.go(AppRoutes.dashboard);
          } else if (state is auth.AuthUnauthenticated) {
            context.go(AppRoutes.login);
          }
        },
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
