
import 'package:civixapp/core/database/remote/error/failureResponse.dart';

sealed class OtpVericationState {}

final class OtpVericationInitial extends OtpVericationState {}

final class OtpVericationFailure extends OtpVericationState {
  FailureResponse failureResponse;
  OtpVericationFailure(this.failureResponse);
}

final class OtpVericationLoading extends OtpVericationState {}

final class OtpVericationSucces extends OtpVericationState {
  dynamic otpsuccessmodel;
  OtpVericationSucces(this.otpsuccessmodel);
}
