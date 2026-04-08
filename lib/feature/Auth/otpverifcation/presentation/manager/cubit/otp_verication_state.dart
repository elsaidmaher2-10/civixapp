import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/feature/Auth/otpverifcation/data/models/globalOtpModel.dart';

sealed class OtpVericationState {}

final class OtpVericationInitial extends OtpVericationState {}

final class OtpVericationFailure extends OtpVericationState {
  FailureResponse failureResponse;
  OtpVericationFailure(this.failureResponse);
}

final class OtpVericationLoading extends OtpVericationState {}

final class OtpVericationSucces extends OtpVericationState {
  OtpResponse  otpsuccessmodel;
  OtpVericationSucces(this.otpsuccessmodel);
}
