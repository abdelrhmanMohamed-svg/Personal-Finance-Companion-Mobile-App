import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment { dev, staging, prod }

class Environment {
  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool supabaseDebug;
  final bool isProduction;

  Environment({
    required this.environment,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    this.supabaseDebug = false,
    this.isProduction = false,
  });

  static Future<Environment> load() async {
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (supabaseUrl == null || supabaseUrl.isEmpty) {
      throw Exception('SUPABASE_URL is not configured in .env file');
    }
    if (supabaseAnonKey == null || supabaseAnonKey.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY is not configured in .env file');
    }

    return Environment(
      environment: AppEnvironment.dev,
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
      supabaseDebug: true,
      isProduction: false,
    );
  }
}
