abstract class CreateReportState {}

class CreateReportInitial extends CreateReportState {}

class CreateReportLoading extends CreateReportState {}

class CreateReportSuccess extends CreateReportState {
  final String message;
  CreateReportSuccess(this.message);
}

class CreateReportFailure extends CreateReportState {
  final String errMessage;
  CreateReportFailure(this.errMessage);
}