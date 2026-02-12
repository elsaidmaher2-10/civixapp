
class ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerInitial
    extends ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerLoading
    extends ConfirmPasswordControllerState {}

final class ConfirmPasswordControllerSuccess
    extends ConfirmPasswordControllerState {
  String  message;
  ConfirmPasswordControllerSuccess(this.message);
}

final class ConfirmPasswordControllerFailure
    extends ConfirmPasswordControllerState {
  ConfirmPasswordControllerFailure({required this.message});
  String message;
}
