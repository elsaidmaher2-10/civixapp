import 'package:citifix/feature/Auth/Login/data/models/loginsuccesresponse.dart';

class LogincontrollerState {}

final class LogincontrollerInitial extends LogincontrollerState {}

final class LogincontrollerLoading extends LogincontrollerState {}

final class LogincontrollerSuccess extends LogincontrollerState {
  Loginsuccesresponse response;
  LogincontrollerSuccess(this.response);
}

final class LogincontrollerFailure extends LogincontrollerState {
  LogincontrollerFailure({required this.message});
  String message;
}
