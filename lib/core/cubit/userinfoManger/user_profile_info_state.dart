part of 'user_profile_info_cubit.dart';

sealed class UserProfileInfoState {}

final class UserProfileInfoInitial extends UserProfileInfoState {}

final class UserProfileInfoLoading extends UserProfileInfoState {}

final class UserProfileImageLoading extends UserProfileInfoState {
  final UserProfile user;
  UserProfileImageLoading(this.user);
}

final class UserProfileInfoSuccess extends UserProfileInfoState {
  final UserProfile user;
  UserProfileInfoSuccess(this.user);
}
final class EditUserProfileInfoLoading extends UserProfileInfoState {}


final class EditUserProfileInfoSuccess extends UserProfileInfoState {
  final UserProfile user;
  EditUserProfileInfoSuccess(this.user);
}

final class UserProfileImageUpdatedSuccess extends UserProfileInfoState {
  final UserProfile user;
  UserProfileImageUpdatedSuccess(this.user);
}

final class UserProfileInfoError extends UserProfileInfoState {
  final String message;
  UserProfileInfoError(this.message);
}
final class EditUserProfileInfoError extends UserProfileInfoState {
  final String message;
  EditUserProfileInfoError(this.message);
}
