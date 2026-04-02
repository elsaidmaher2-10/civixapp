import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/VerificationrequestModel.dart';
import '../../data/model/verficationmodel.dart';
import '../../data/repo/VerficationInitRepo.dart';

class VerificationInitCubit extends Cubit<VerificationInitState> {
  final VerficationInitRepo repo;

  VerificationInitCubit(this.repo) : super(VerificationInitInitial()) {
    loadInitialData();
  }
  VerficationInitList? areasList;
  VerficationInitList? departmentsList;

  Future<void> loadInitialData() async {
    emit(VerificationInitLoading());
    final results = await Future.wait([
      repo.getAreas(),
      repo.getDepartmentname(),
    ]);

    final areasResult = results[0];
    final departmentsResult = results[1];

    areasResult.fold(
      (failure) => emit(VerificationInitError(failure.errors.first)),
      (areas) {
        areasList = areas;
        departmentsResult.fold(
          (failure) => emit(VerificationInitError(failure.errors.first)),
          (departments) {
            departmentsList = departments;
            emit(
              VerificationInitSuccess(
                areas: areasList!,
                departments: departmentsList!,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> sendVerificationRequest({
    required VerificationrequestModel request,
  }) async {
    emit(VerificationRequestLoading());
    final result = await repo.verificationrequest(request: request);
    result.fold(
      (failure) {
        emit(VerificationRequestError(failure.errors.first));
      },
      (response) {
        emit(VerificationRequestSuccess("Request sent successfully"));
      },
    );
  }
}
