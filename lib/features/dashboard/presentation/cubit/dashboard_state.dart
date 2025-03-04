part of 'dashboard_cubit.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<TaskModel> tasks;
  DashboardLoaded(this.tasks);
}

class DashboardError extends DashboardState {
  final String error;
  DashboardError(this.error);
}
