import 'package:flutter_bloc/flutter_bloc.dart';
import 'ReportDetailsState.dart';
import '../../data/repos/reportdetails.dart';

class ReportDetailsManager extends Cubit<ReportDetailsState> {
  final ReportdetailsRepo _reportdetailsRepo;

  ReportDetailsManager({required ReportdetailsRepo reportdetailsRepo})
    : _reportdetailsRepo = reportdetailsRepo,
      super(ReportDetailsInitial());

  Future<void> getReportDetails({required int id}) async {
    emit(ReportDetailsLoading());
    final data = await _reportdetailsRepo.getReportDetails(reportid: id);
    data.fold((ifLeft) => emit(ReportDetailsFailure(ifLeft.errors.join())), (
      ifRight,
    ) {
      emit(ReportDetailsSuccess(ifRight));
    });
  }
}
