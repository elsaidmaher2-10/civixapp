part of 'user_profile_info_cubit.dart';

@immutable
sealed class UserProfileInfoState {}

final class UserProfileInfoInitial extends UserProfileInfoState {}

final class UserProfileInfoLoading extends UserProfileInfoState {}

final class UserProfileInfoSuccess extends UserProfileInfoState {
  final UserProfile user;

  UserProfileInfoSuccess(this.user);
}

final class UserProfileInfoError extends UserProfileInfoState {
  final String message;

  UserProfileInfoError(this.message);
}

final class UserProfileInfoImageUpdated extends UserProfileInfoState {
  final String message;
  UserProfileInfoImageUpdated(this.message);
}
