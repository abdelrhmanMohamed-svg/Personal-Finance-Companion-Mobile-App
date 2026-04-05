import '../../domain/entities/dashboard_entity.dart';
import '../../../transactions/domain/entities/transaction.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardEntity dashboard;
  final List<Transaction> recentTransactions;

  DashboardLoaded(this.dashboard, {this.recentTransactions = const []});
}

class DashboardEmpty extends DashboardState {}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
