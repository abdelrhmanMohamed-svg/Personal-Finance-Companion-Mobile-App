import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/usecases/get_dashboard_summary.dart';
import '../../domain/usecases/get_recent_transactions.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardSummary _getDashboardSummary;
  final GetRecentTransactions _getRecentTransactions;
  final SupabaseClient _supabaseClient;

  DashboardCubit({
    required GetDashboardSummary getDashboardSummary,
    required GetRecentTransactions getRecentTransactions,
    required SupabaseClient supabaseClient,
  })  : _getDashboardSummary = getDashboardSummary,
        _getRecentTransactions = getRecentTransactions,
        _supabaseClient = supabaseClient,
        super(DashboardInitial());

  void loadDashboard() {
    emit(DashboardLoading());
    _fetchData();
  }

  Future<void> refreshDashboard() async {
    await _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        emit(DashboardError('User not authenticated'));
        return;
      }

      final dashboard = await _getDashboardSummary(userId);
      final recentTransactions = await _getRecentTransactions(userId, limit: 5);

      if (dashboard.totalIncome == 0 &&
          dashboard.totalExpenses == 0 &&
          recentTransactions.isEmpty) {
        emit(DashboardEmpty());
      } else {
        emit(
            DashboardLoaded(dashboard, recentTransactions: recentTransactions));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
