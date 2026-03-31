import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/Models/Achievment/achievementModel.dart';
import '../../../data/repos/reports/reports.dart';
import 'achicvementState.dart';

class AchievementCubit extends Cubit<AchievementState> {
  final ReportRepositoryT repo;

  AchievementCubit(this.repo) : super(AchievementInitial());

  int offset = 0;
  final int limit = 10;

  bool isLoading = false;
  bool hasMore = true;

  List<Achievementmodel> reports = [];

  Future<void> getAchievements() async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (offset == 0) {
      emit(AchievementLoading());
    }

    final result = await repo.achievment();

    result.fold(
      (failure) {
        emit(AchievementError(failure.errors.first));
      },
      (response) {
        reports.addAll(response.items);
        offset += limit;
        if (reports.length >= response.totalCount) {
          hasMore = false;
        }
        emit(AchievementSuccess(reports: List.from(reports), hasMore: hasMore));
      },
    );

    isLoading = false;
  }

  Future<void> refresh() async {
    offset = 0;
    hasMore = true;
    reports.clear();
    await getAchievements();
  }
}
