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
