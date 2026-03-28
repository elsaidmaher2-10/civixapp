import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final DashBroadHome dashboardData;
  HomeSuccess(this.dashboardData);
}

final class HomeError extends HomeState {
  final String errorMessage;
  HomeError(this.errorMessage);
}