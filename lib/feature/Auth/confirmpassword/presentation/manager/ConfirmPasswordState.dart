class ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerInitial
    extends ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerLoading
    extends ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerSuccess
    extends ConfirmPasswordControllerState {
  String message;
  ConfirmPasswordControllerSuccess(this.message);
}

final class ConfirmPasswordControllerFailure
    extends ConfirmPasswordControllerState {
  ConfirmPasswordControllerFailure({required this.message});
  String message;
}

final class ChangePasswordInitial extends ConfirmPasswordControllerState {}

final class ChangePasswordLoading extends ConfirmPasswordControllerState {}

final class ChangePasswordSuccess extends ConfirmPasswordControllerState {
  String message;
  ChangePasswordSuccess(this.message);
}

final class ChangePasswordFailure extends ConfirmPasswordControllerState {
  ChangePasswordFailure({required this.message});
  String message;
}
