import 'package:citifix/feature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:citifix/feature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportManagerState> {
  final ReportRepository reportRepository;
  ReportCubit(this.reportRepository) : super(ReportManagerInitial());
  List<ReportResponseModel> _allReports = [];
  Future<void> fetchReports() async {
    if (isClosed) return;
    emit(GetReportsLoading());

    final result = await reportRepository.getReports();
    if (isClosed) return;

    result.fold((failure) => emit(GetReportsFailure(failure.errors.first)), (
      reports,
    ) {
      _allReports = reports;
      emit(GetReportsSuccess(List.from(_allReports)));
    });
  }

  Future<void> createReport({required CreateReportRequest request}) async {
    emit(CreateReportLoading());
    final result = await reportRepository.addReport(request: request);
    result.fold((failure) => emit(CreateReportFailure(failure.errors.first)), (
      successMessage,
    ) async {
      emit(CreateReportSuccess(successMessage));
      await fetchReports();
    });
  }

  void searchReport({required String query}) async {
    if (query.isEmpty) {
      emit(GetReportsSuccess(List.from(_allReports)));
      return;
    }
    emit(SearchLoading());
    await Future.delayed(Duration(seconds: 2));
    final filteredList = _allReports.where((e) {
      return e.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filteredList.isNotEmpty) {
      emit(SearchReportsSuccess(filteredList));
    } else {
      emit(SearchReportsFailure("No reports found for '$query'"));
    }
  }

  void resetSearch() {
    emit(GetReportsSuccess(List.from(_allReports)));
  }
}
