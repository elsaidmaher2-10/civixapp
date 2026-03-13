import 'package:bloc/bloc.dart';
import 'package:citifix/feature/home/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/home/data/Repos/reports/reports.dart';
import 'package:citifix/feature/home/presentation/manager/reportManger/cubit/report_manager_state.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  final ReportRepository reportRepository;

  CreateReportCubit(this.reportRepository) : super(CreateReportInitial());

  Future<void> createReport({required CreateReportRequest request}) async {
    emit(CreateReportLoading());
    final result = await reportRepository.addReport(request: request);

    result.fold(
      (failure) {
        emit(CreateReportFailure(failure.errors.first));
      },
      (successMessage) {
        emit(CreateReportSuccess(successMessage));
      },
    );
  }
}