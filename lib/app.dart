import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_companion_mobile_app/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'core/services/dependency_injection.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';

class PersonalFinanceApp extends StatelessWidget {
  const PersonalFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(getIt<SupabaseService>()),
        ),
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

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
  ],
);
