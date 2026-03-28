import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/reports/reports.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportManagerState> {
  final ReportRepository reportRepository;
  ReportCubit(this.reportRepository) : super(ReportManagerInitial());

  List<ReportItem> _allReports = [];

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
    if (isClosed) return;
    emit(CreateReportLoading());

    final result = await reportRepository.addReport(request: request);

    if (isClosed) return;

    result.fold((failure) => emit(CreateReportFailure(failure.errors.first)), (
      successMessage,
    ) async {
      emit(CreateReportSuccess(successMessage));

      if (!isClosed) {
        await fetchReports();
      }
    });
  }

  Future<void> GetReportByID({required int ReportID}) async {
    if (isClosed) return;
    emit(GetReportsByidLoading());

    final result = await reportRepository.getReportByid(ReportID: ReportID);

    if (isClosed) return;

    result.fold(
      (failure) => emit(GetReportsByidFailure(failure.errors.first)),
      (ReportResponseModelByid successMessage) async {
        emit(GetReportsByidSuccess(successMessage));
      },
    );
  }

  void searchReport({required String query}) async {
    if (isClosed) return;

    if (query.isEmpty) {
      emit(GetReportsSuccess(List.from(_allReports)));
      return;
    }

    emit(SearchLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (isClosed) return;

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
    if (isClosed) return;
    emit(GetReportsSuccess(List.from(_allReports)));
  }
}
