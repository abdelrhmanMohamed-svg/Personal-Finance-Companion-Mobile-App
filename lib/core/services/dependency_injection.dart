import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/environment.dart';
import 'supabase_service.dart';
import '../../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/presentation/cubits/transactions_cubit.dart';
import '../../features/dashboard/data/datasources/dashboard_datasource.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_summary.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final env = Environment.development;

  await Supabase.initialize(
    url: env.supabaseUrl,
    anonKey: env.supabaseAnonKey,
    debug: env.supabaseDebug,
  );

  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService(getIt()));

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<SupabaseClient>()),
  );

  getIt.registerFactory<TransactionsCubit>(
    () => TransactionsCubit(
      getIt<TransactionRepository>(),
      getIt<SupabaseClient>(),
    ),
  );

  getIt.registerLazySingleton<DashboardDataSource>(
    () => DashboardDataSource(getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt<DashboardDataSource>()),
  );

  getIt.registerFactory<GetDashboardSummary>(
    () => GetDashboardSummary(getIt<DashboardRepository>()),
  );

  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      getDashboardSummary: getIt<GetDashboardSummary>(),
      supabaseClient: getIt<SupabaseClient>(),
    ),
  );
}
