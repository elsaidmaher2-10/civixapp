import 'package:citifix/feature/notication/data/model/notifavtionmodel.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationBadge extends NotificationState {
  int badge;
  NotificationBadge(this.badge);
}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  const NotificationLoaded(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);
}
