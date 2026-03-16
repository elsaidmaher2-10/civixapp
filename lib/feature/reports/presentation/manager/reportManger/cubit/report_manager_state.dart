import 'package:citifix/feature/reports/data/Models/Report/CreateReportResponseModel.dart';

abstract class ReportManagerState {}

class ReportManagerInitial extends ReportManagerState {}

class GetReportsLoading extends ReportManagerState {}
class GetReportsSuccess extends ReportManagerState {
  final List<ReportResponseModel> reports;
  GetReportsSuccess(this.reports);
}
class GetReportsFailure extends ReportManagerState {
  final String errMessage;
  GetReportsFailure(this.errMessage);
}

class CreateReportLoading extends ReportManagerState {}
class CreateReportSuccess extends ReportManagerState {
  final String message;
  CreateReportSuccess(this.message);
}
class CreateReportFailure extends ReportManagerState {
  final String errMessage;
  CreateReportFailure(this.errMessage);
}