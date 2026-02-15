part of 'otp_verication_cubit.dart';

sealed class OtpVericationState {}

final class OtpVericationInitial extends OtpVericationState {}

final class OtpVericationFailure extends OtpVericationState {
  FailureResponse failureResponse;
  OtpVericationFailure(this.failureResponse);
}

final class OtpVericationLoading extends OtpVericationState {}

final class OtpVericationSucces extends OtpVericationState {
  Otpsuccessmodel otpsuccessmodel;
  OtpVericationSucces(this.otpsuccessmodel);
}
