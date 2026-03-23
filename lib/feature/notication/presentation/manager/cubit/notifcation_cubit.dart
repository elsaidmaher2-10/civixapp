import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/feature/notication/data/model/notifavtionmodel.dart';
import 'package:citifix/feature/notication/data/repo/noticationRepo.dart';
import 'package:citifix/feature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo repo;

  NotificationCubit(this.repo) : super(NotificationInitial()) {
    calcBage();
  }
  int numberbage = 0;
  Future<void> getNotifications() async {
    emit(NotificationLoading());
    final Either<FailureResponse, List<NotificationModel>> response = await repo
        .getNotifications();

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (notifications) {
        numberbage = notifications.length;
        emit(NotificationLoaded(notifications));
      },
    );
  }

  Future<void> markAsRead(int id) async {
    emit(NotificationLoading());
    final Either<FailureResponse, dynamic> response = await repo.markAsRead(
      id: id,
    );

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (_) => getNotifications(),
    );
  }

  Future<void> deleteNotification(int id) async {
    emit(NotificationLoading());
    final Either<FailureResponse, Map> response = await repo.deleteNotification(
      id: id,
    );

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (_) => getNotifications(),
    );
  }

  Future<void> clearAllNotifications() async {
    emit(NotificationLoading());
    final Either<FailureResponse, Map> response = await repo
        .clearAllNotifications();

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (_) => getNotifications(),
    );
  }

  Future<void> registerDevice(String token, String platform) async {
    final Either<FailureResponse, String> response = await repo.registerDevice(
      deviceToken: token,
      platform: platform,
    );

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (_) => null,
    );
  }

  Future<void> refreshNotifications() async {
    await getNotifications();
  }

  void calcBage() {
    emit(NotificationBadge(numberbage));
  }
}
