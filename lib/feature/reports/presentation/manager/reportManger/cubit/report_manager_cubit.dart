import 'package:bloc/bloc.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/reports/data/repos/reports/reports.dart';
import 'report_manager_state.dart';

class ReportCubit extends Cubit<ReportManagerState> {
  final ReportRepository reportRepository;

  ReportCubit(this.reportRepository) : super(ReportManagerInitial());

  Future<void> fetchReports() async {
    if (isClosed) return;
    emit(GetReportsLoading());

    final result = await reportRepository.getReports();
    if (isClosed) return;

    result.fold(
      (failure) => emit(GetReportsFailure(failure.errors.first)),
      (reports) => emit(GetReportsSuccess([...reports])),
    );
  }

  Future<void> createReport({required CreateReportRequest request}) async {
    emit(CreateReportLoading());

    final result = await reportRepository.addReport(request: request);

    await result.fold(
      (failure) async => emit(CreateReportFailure(failure.errors.first)),
      (successMessage) async {
        emit(CreateReportSuccess(successMessage));

        await fetchReports();
      },
    );
  }
}
