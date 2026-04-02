import '../../data/model/verficationmodel.dart';

abstract class VerificationInitState {}

class VerificationInitInitial extends VerificationInitState {}

class VerificationInitLoading extends VerificationInitState {}

class VerificationInitSuccess extends VerificationInitState {
  final VerficationInitList areas;
  final VerficationInitList departments;
  VerificationInitSuccess({required this.areas, required this.departments});
}

class VerificationInitError extends VerificationInitState {
  final String message;

  VerificationInitError(this.message);
}

class VerificationRequestLoading extends VerificationInitState {}

class VerificationRequestSuccess extends VerificationInitState {
  final String message;
  VerificationRequestSuccess(this.message);
}

class VerificationRequestError extends VerificationInitState {
  final String errorMessage;
  VerificationRequestError(this.errorMessage);
}
