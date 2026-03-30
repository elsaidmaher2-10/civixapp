import 'dart:async'; // نحتاجها للـ StreamSubscription
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/feature/citzenFeature/notication/data/model/notifavtionmodel.dart';
import 'package:citifix/feature/citzenFeature/notication/data/repo/noticationRepo.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // إضافة فايربيس
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo repo;

  StreamSubscription? _messagingSubscription;

  NotificationCubit(this.repo) : super(NotificationInitial()) {
    getNotifications();
    _listenToRealTimeNotifications();
  }

  void _listenToRealTimeNotifications() {
    _messagingSubscription = FirebaseMessaging.onMessage.listen((
      RemoteMessage message,
    ) {
      _getNotificationsSilent();
    });
  }

  Future<void> _getNotificationsSilent() async {
    final Either<FailureResponse, List<NotificationModel>> response = await repo
        .getNotifications();

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (notifications) {
        emit(NotificationLoaded(notifications));
      },
    );
  }

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    final Either<FailureResponse, List<NotificationModel>> response = await repo
        .getNotifications();

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (notifications) {
        emit(NotificationLoaded(notifications));
      },
    );
  }

  Future<void> markAsRead(int id) async {
    final Either<FailureResponse, dynamic> response = await repo.markAsRead(
      id: id,
    );

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (_) => _getNotificationsSilent(),
    );
  }

  Future<void> deleteNotification(int id) async {
    final Either<FailureResponse, Map> response = await repo.deleteNotification(
      id: id,
    );

    response.fold(
      (failure) => emit(NotificationError(failure.errors.join(", "))),
      (_) => _getNotificationsSilent(),
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

  Future<void> markAllNotificationsAsRead() async {
    final Either<FailureResponse, Map> response = await repo
        .markAllNotificationsAsRead();
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
    await _getNotificationsSilent();
  }

  @override
  Future<void> close() {
    _messagingSubscription?.cancel();
    return super.close();
  }
}
