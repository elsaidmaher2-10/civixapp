import 'package:citifix/feature/workerFeature/taskDetails/data/model/taskdetailsmodel.dart';

sealed class ReportDetailsState {}

class ReportDetailsInitial extends ReportDetailsState {}

class ReportDetailsLoading extends ReportDetailsState {}

class ReportDetailsFailure extends ReportDetailsState {
  final String error;

  ReportDetailsFailure(this.error);
}

class ReportDetailsSuccess extends ReportDetailsState {
  final TaskDetailsModel data;

  ReportDetailsSuccess(this.data);
}

class MarkAsCompeleteLoading extends ReportDetailsState {}

class MarkAsCompeleteFailure extends ReportDetailsState {
  final String error;

  MarkAsCompeleteFailure(this.error);
}

class MarkAsCompeleteSuccess extends ReportDetailsState {
  final bool data;
  MarkAsCompeleteSuccess(this.data);
}
