import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/supabase_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseService _supabaseService;

  AuthCubit(this._supabaseService) : super(const AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(const AuthLoading());
    try {
      if (_supabaseService.isAuthenticated) {
        final user = _supabaseService.currentUser;
        if (user != null) {
          emit(AuthAuthenticated(user.id));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(const AuthLoading());
    try {
      final response = await _supabaseService.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        emit(AuthAuthenticated(response.user!.id));
      } else {
        emit(const AuthError('Sign in failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(const AuthLoading());
    try {
      final response = await _supabaseService.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        emit(AuthAuthenticated(response.user!.id));
      } else {
        emit(const AuthError('Sign up failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());
    try {
      await _supabaseService.signOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
