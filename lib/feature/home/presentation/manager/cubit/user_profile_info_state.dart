part of 'user_profile_info_cubit.dart';

@immutable
sealed class UserProfileInfoState {}

/// البداية
final class UserProfileInfoInitial extends UserProfileInfoState {}

/// أثناء تحميل البيانات
final class UserProfileInfoLoading extends UserProfileInfoState {}

/// نجح جلب البيانات
final class UserProfileInfoSuccess extends UserProfileInfoState {
  final UserProfile user;

  UserProfileInfoSuccess(this.user);
}

/// لو حصل خطأ
final class UserProfileInfoError extends UserProfileInfoState {
  final String message;

  UserProfileInfoError(this.message);
}
