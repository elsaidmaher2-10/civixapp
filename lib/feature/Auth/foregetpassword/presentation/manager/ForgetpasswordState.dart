class Forgetpasswordstate {}
final class ForgetpasswordstatecontrollerInitial extends Forgetpasswordstate {}
final class ForgetpasswordstatecontrollerLoading extends Forgetpasswordstate {}
final class ForgetpasswordstatecontrollerSuccess extends Forgetpasswordstate {
  String response;
  ForgetpasswordstatecontrollerSuccess(this.response);
}
final class ForgetpasswordstatecontrollerFailure extends Forgetpasswordstate {
  ForgetpasswordstatecontrollerFailure({required this.message});
  String message;
}
