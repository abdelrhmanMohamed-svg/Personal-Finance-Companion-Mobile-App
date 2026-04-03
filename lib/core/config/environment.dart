enum AppEnvironment { dev, staging, prod }

class Environment {
  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool supabaseDebug;
  final bool isProduction;

  const Environment({
    required this.environment,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    this.supabaseDebug = false,
    this.isProduction = false,
  });

  static Environment get development => const Environment(
        environment: AppEnvironment.dev,
        supabaseUrl: '',
        supabaseAnonKey: '',
        supabaseDebug: true,
        isProduction: false,
      );

  static Environment get staging => const Environment(
        environment: AppEnvironment.staging,
        supabaseUrl: '',
        supabaseAnonKey: '',
        supabaseDebug: true,
        isProduction: false,
      );

  static Environment get production => const Environment(
        environment: AppEnvironment.prod,
        supabaseUrl: '',
        supabaseAnonKey: '',
        supabaseDebug: false,
        isProduction: true,
      );
}
