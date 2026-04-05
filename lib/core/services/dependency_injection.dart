import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/environment.dart';
import 'supabase_service.dart';
import '../../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/presentation/cubits/transactions_cubit.dart';

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
}
