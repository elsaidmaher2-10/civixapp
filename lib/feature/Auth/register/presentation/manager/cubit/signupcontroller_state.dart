
 class SignupcontrollerState {}

final class SignupcontrollerInitial extends SignupcontrollerState {}

final class Signupcontrollerloading extends SignupcontrollerState {}

final class Signupcontrollersucess extends SignupcontrollerState {}

final class Signupcontrollerfailure extends SignupcontrollerState {
  Signupcontrollerfailure({required this.message});
  String message;
}
