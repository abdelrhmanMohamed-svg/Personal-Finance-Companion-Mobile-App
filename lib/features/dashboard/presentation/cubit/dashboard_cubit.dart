import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/usecases/get_dashboard_summary.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardSummary _getDashboardSummary;
  final SupabaseClient _supabaseClient;

  DashboardCubit({
    required GetDashboardSummary getDashboardSummary,
    required SupabaseClient supabaseClient,
  })  : _getDashboardSummary = getDashboardSummary,
        _supabaseClient = supabaseClient,
        super(DashboardInitial());

  void loadDashboard() {
    emit(DashboardLoading());
    _fetchData();
  }

  void refreshDashboard() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        emit(DashboardError('User not authenticated'));
        return;
      }

      final dashboard = await _getDashboardSummary(userId);

      if (dashboard.totalIncome == 0 && dashboard.totalExpenses == 0) {
        emit(DashboardEmpty());
      } else {
        emit(DashboardLoaded(dashboard));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
