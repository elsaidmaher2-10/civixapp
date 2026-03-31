import 'package:citifix/feature/citzenFeature/reports/data/Models/Achievment/achievementModel.dart';

abstract class AchievementState {}

class AchievementInitial extends AchievementState {}

class AchievementLoading extends AchievementState {}

class AchievementSuccess extends AchievementState {
  final List<Achievementmodel> reports;
  final bool hasMore;

  AchievementSuccess({required this.reports, required this.hasMore});
}

class AchievementError extends AchievementState {
  final String message;

  AchievementError(this.message);
}
