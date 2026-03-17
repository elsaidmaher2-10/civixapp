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

class SearchLoading extends ReportManagerState {}

class SearchReportsSuccess extends ReportManagerState {
  final List<ReportResponseModel> reports;
  SearchReportsSuccess(this.reports);
}

class SearchReportsFailure extends ReportManagerState {
  final String errMessage;
  SearchReportsFailure(this.errMessage);
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
