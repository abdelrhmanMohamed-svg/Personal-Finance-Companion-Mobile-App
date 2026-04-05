import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/insights_repository.dart';
import 'insights_state.dart';

class InsightsCubit extends Cubit<InsightsState> {
  final InsightsRepository _insightsRepository;
  final SupabaseClient _supabaseClient;

  InsightsCubit({
    required InsightsRepository insightsRepository,
    required SupabaseClient supabaseClient,
  })  : _insightsRepository = insightsRepository,
        _supabaseClient = supabaseClient,
        super(InsightsInitial());

  Future<void> loadInsights() async {
    emit(InsightsLoading());

    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        emit(const InsightsError('User not authenticated'));
        return;
      }

      final categoryBreakdown =
          await _insightsRepository.getSpendingByCategory(userId);
      final weeklyComparison =
          await _insightsRepository.getWeeklyComparison(userId);
      final monthlyTrends = await _insightsRepository.getMonthlyTrends(userId);
      final topCategory = await _insightsRepository.getTopCategory(userId);

      if (categoryBreakdown.isEmpty &&
          weeklyComparison.currentWeekTotal == 0 &&
          weeklyComparison.previousWeekTotal == 0 &&
          monthlyTrends.isEmpty) {
        emit(InsightsEmpty());
      } else {
        emit(InsightsLoaded(
          categoryBreakdown: categoryBreakdown,
          weeklyComparison: weeklyComparison,
          monthlyTrends: monthlyTrends,
          topCategory: topCategory,
        ));
      }
    } catch (e) {
      emit(InsightsError(e.toString()));
    }
  }

  Future<void> refreshInsights() async {
    await loadInsights();
  }
}
