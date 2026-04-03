import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/environment.dart';
import 'supabase_service.dart';

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
}
