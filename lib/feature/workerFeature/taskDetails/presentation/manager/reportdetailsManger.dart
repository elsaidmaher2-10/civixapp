import 'dart:io';

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
    data.fold(
      (ifLeft) {
        if (isClosed) return;

        emit(ReportDetailsFailure(ifLeft.errors.join()));
      },
      (ifRight) {
        if (isClosed) return;
        emit(ReportDetailsSuccess(ifRight));
      },
    );
  }

  Future<void> markAsCompleted({
    required int id,
    required String notes,
    required List<File> images,
  }) async {
    emit(MarkAsCompeleteLoading());
    final data = await _reportdetailsRepo.markasCompeleted(
      reportId: id,
      notes: notes,
      images: images,
    );
    data.fold((ifLeft) => emit(MarkAsCompeleteFailure(ifLeft.errors.join())), (
      ifRight,
    ) {
      emit(MarkAsCompeleteSuccess(true));
    });
  }
}
